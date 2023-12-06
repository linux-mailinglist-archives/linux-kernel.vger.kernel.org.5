Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E06980657A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 04:12:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbjLFDML (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 22:12:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjLFDMK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 22:12:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503F31AA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 19:12:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755B4C433C7;
        Wed,  6 Dec 2023 03:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1701832336;
        bh=lTHpF9Bti1w65vYiC1cnqYOAb09SPxfwZH3wTHGdKGs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nsk8LGL8rZUevibrNp9VycS3Ts/i/qovwSjTyj0lZGoABYFWLf3hXOiM6HQjb/Zj8
         9jxgRJSZLWBW+UEsmX+Ef6P/mO5LqHc26jy5VolPFDzhf3Vc2tZfmENkW53VKWssaq
         pKi/rWLanfouDImA9l3BctRWwYxJ0Ns20wABdfRM=
Date:   Wed, 6 Dec 2023 12:12:10 +0900
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
Cc:     Sourav Panda <souravpanda@google.com>, corbet@lwn.net,
        rafael@kernel.org, akpm@linux-foundation.org,
        mike.kravetz@oracle.com, muchun.song@linux.dev, rppt@kernel.org,
        david@redhat.com, rdunlap@infradead.org, chenlinxuan@uniontech.com,
        yang.yang29@zte.com.cn, tomas.mudrunka@gmail.com,
        bhelgaas@google.com, ivan@cloudflare.com, yosryahmed@google.com,
        hannes@cmpxchg.org, shakeelb@google.com,
        kirill.shutemov@linux.intel.com, wangkefeng.wang@huawei.com,
        adobriyan@gmail.com, vbabka@suse.cz, Liam.Howlett@oracle.com,
        surenb@google.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, willy@infradead.org, weixugc@google.com
Subject: Re: [PATCH v6 0/1] mm: report per-page metadata information
Message-ID: <2023120645-survey-puppet-4ae0@gregkh>
References: <20231205223118.3575485-1-souravpanda@google.com>
 <2023120648-droplet-slit-0e31@gregkh>
 <CA+CK2bARjZgnMBL9bOD7p1u=02-fGgWwfiGvsFVpsJWL-VR2ng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+CK2bARjZgnMBL9bOD7p1u=02-fGgWwfiGvsFVpsJWL-VR2ng@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 05, 2023 at 09:57:36PM -0500, Pasha Tatashin wrote:
> Hi Greg,
> 
> Sourav removed the new field from sys/device../nodeN/meminfo as you
> requested; however, in nodeN/vmstat fields still get appended, as
> there is code that displays every item in zone_stat_item,
> node_stat_item without option to opt-out. I mentioned it to you at
> LPC.

Sorry, I thought that was a proc file, not a sysfs file.  Don't grow
that file please, it should not be that way and adding to it will just
cause others to also want to add to it and we end up with the whole proc
file mess...

> In my IOMMU [1] series, there are also fields that are added to
> node_stat_item that as result are appended to nodeN/vmstat.

I missed that, that too shouldn't be done please.

Again, sysfs is "one value per file" for a reason, don't abuse the fact
that we missed this abuse of the rules for that file by adding more
things to it.

thanks,

greg k-h
