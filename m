Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56DC7DDA52
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 01:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376950AbjKAAgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 20:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376932AbjKAAgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 20:36:22 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6B9F3;
        Tue, 31 Oct 2023 17:36:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 7973760173;
        Wed,  1 Nov 2023 01:36:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698798971; bh=7+OnU03hnEgdpDmnONAOnNrmZzBC/v9M+zILGmMnYVs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=2KOLpL38q0G2qKze6WO6dSOZRCb5zHCOkVr5U4Z7OMWkVLUa1hgS6yrNTR/J4zv7v
         x5LC+ipe7D9riZxgq4WHcQySuTcM9Pwd3CHuhUtUVQnR7VhXU+U/j36wTo3ub2hYAI
         lsBPhCUsmSh0krJxLkmD7h77pS2W8uyiCHVLmTVBFXYRmdb2XZm0jGB7+Qo2IvjwYS
         xHY8lyil58e+Dv6qPj718fbxbC6Dx1vMTGCDirpGJv1DXp6nroGBJZqPPCzYSCzzlS
         uYgIbsaf/P+8Fm+kH+jA4Ywq31DGC60gDZa9RhK/EagIQKp4EIeqzX8mfrWwRJ3uo9
         oiXG6AwnAUR1A==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VO-KPkDgqbXm; Wed,  1 Nov 2023 01:36:08 +0100 (CET)
Received: from [192.168.1.6] (78-2-88-80.adsl.net.t-com.hr [78.2.88.80])
        by domac.alu.hr (Postfix) with ESMTPSA id 139DE60171;
        Wed,  1 Nov 2023 01:36:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1698798968; bh=7+OnU03hnEgdpDmnONAOnNrmZzBC/v9M+zILGmMnYVs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sep5SPp7jEs9UZ+p2yIjxq6FZhm6zz7bhVx2M7FWKIpDBMHktoFo35jLkJMFSeP9+
         XBiefuRdHgBdQLSQ4F9r3a4ZfxGmo/9c0CAtOmVSsr28gPIjbdt0Qh7tx+v5N5RQOr
         FON028Ysh6IgS124y4p4oqNJh4Aw/wNgyM1kgIDkuUvHjHJrocIpaaDGuExxwCU2P/
         6iniHgAEBN8+jfPx17xH89wEJ4sExbgXtSm0ADNBoy+3UTvDKGKn7AzWEOEG/yYV9i
         6VTWz7aKge/EXVKkNLbcTmFMvrp547+mLo5j4lvWtKD7wwgcI4dTK0lDzG3UwVHmyI
         wGeQFORljFG0w==
Message-ID: <4126706e-87f7-40d9-a896-8fc869a0f41d@alu.unizg.hr>
Date:   Wed, 1 Nov 2023 01:35:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] r8169: Coalesce r8169_mac_ocp_write/modify calls
 to reduce spinlock stalls
To:     Jacob Keller <jacob.e.keller@intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <jroedel@suse.de>,
        Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, nic_swsd@realtek.com,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Marco Elver <elver@google.com>
References: <20231029110442.347448-1-mirsad.todorovac@alu.unizg.hr>
 <e7a6b0c1-9fc6-480c-a135-7e142514d0e7@intel.com>
 <a85e41ab-7cfa-413a-a446-f1b65c09c9ab@gmail.com>
 <e1c666d8-c7f0-440e-b362-3dbb7a67b242@intel.com>
 <19e2d5fc-7e30-4bb2-943c-f83b44099192@alu.unizg.hr>
 <f2f3a5dc-8b00-400a-9d3f-f10663ce8857@intel.com>
Content-Language: en-US
From:   Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <f2f3a5dc-8b00-400a-9d3f-f10663ce8857@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/31/23 20:46, Jacob Keller wrote:
> 
> 
> On 10/30/2023 8:51 PM, Mirsad Todorovac wrote:
>> Am I allowed to keep Mr. Keller's Reviewed-by: tags on the reviewed diffs provided
>> that I fix the cover letter issue and objections?
>>
> 
> I have no objections as long as the content otherwise remains the same :)
> 
> Thanks,
> Jake

Of course, one changed character would require another review.

Thank you.

Mirsad
