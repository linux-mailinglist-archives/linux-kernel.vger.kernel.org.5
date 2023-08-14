Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 222D977BBB5
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 16:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjHNOcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 10:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbjHNOcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 10:32:00 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20AC6E4;
        Mon, 14 Aug 2023 07:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Ay1rTroirnmemG/EOx5vN4q0IrGCDWTLQUSvpOgdtJo=; b=gvoMcqWgknrjch0StNOzR22eoc
        rL8ccmeUSrYG/x608Pjw/5lP2XxAvBxTwZ8uXmK/W/1W8Mej5fBsRZ3aS267AlICcgWpM1rauvUEj
        wutv3fkRlWb5EtvxzHRmQybXu0FiOkXC1pdOj60c/ARgBD6Q782QqHAjuMbT34UQ1G9M=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qVYbK-0043O3-CL; Mon, 14 Aug 2023 16:31:22 +0200
Date:   Mon, 14 Aug 2023 16:31:22 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Quan, Evan" <Evan.Quan@amd.com>
Cc:     "Limonciello, Mario" <Mario.Limonciello@amd.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "mdaenzer@redhat.com" <mdaenzer@redhat.com>,
        "maarten.lankhorst@linux.intel.com" 
        <maarten.lankhorst@linux.intel.com>,
        "tzimmermann@suse.de" <tzimmermann@suse.de>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "jingyuwang_vip@163.com" <jingyuwang_vip@163.com>,
        "Lazar, Lijo" <Lijo.Lazar@amd.com>,
        "jim.cromie@gmail.com" <jim.cromie@gmail.com>,
        "bellosilicio@gmail.com" <bellosilicio@gmail.com>,
        "andrealmeid@igalia.com" <andrealmeid@igalia.com>,
        "trix@redhat.com" <trix@redhat.com>,
        "jsg@jsg.id.au" <jsg@jsg.id.au>, "arnd@arndb.de" <arnd@arndb.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH V7 4/9] wifi: mac80211: Add support for ACPI WBRF
Message-ID: <b30be221-783e-4e56-a9b3-d4df885cdd00@lunn.ch>
References: <20230719090020.2716892-1-evan.quan@amd.com>
 <20230719090020.2716892-5-evan.quan@amd.com>
 <9b1f45f9-02a3-4c03-b9d5-cc3b9ab3a058@lunn.ch>
 <7d059aed-fac0-cdcd-63d5-58185bb345db@amd.com>
 <DM6PR12MB26196A993B3BA93392AA0FEDE403A@DM6PR12MB2619.namprd12.prod.outlook.com>
 <d4cfbbae-9cd0-4767-8c80-ec09d1dbaf9c@lunn.ch>
 <6aa9061b-1702-b8f2-9cb8-982895b9def4@amd.com>
 <5e92b45a-d99b-4a8a-9987-46c75a5fcb3c@lunn.ch>
 <DM6PR12MB26196A508D4B3523E38C0761E417A@DM6PR12MB2619.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM6PR12MB26196A508D4B3523E38C0761E417A@DM6PR12MB2619.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 09:50:49AM +0000, Quan, Evan wrote:
> [AMD Official Use Only - General]
> 
> Hi Andrew,
> 
> I sent out a new V8 series last week.
> A kernel parameter `wbrf` was introduced there to decide the policy.
> Please help to check whether that makes sense to you.
> Please share your insights there.

netdev has a pretty strong policy of not adding new kernel
parameters. It is a really painful interface to use, and there are
generally better configuration interfaces within netdev.

However, as far as i can see, it is outside of netdev, so this policy
does not necessarily apply.

     Andrew
