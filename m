Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 715D77FA956
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:56:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbjK0S4I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjK0S4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:56:05 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2F8EDD59;
        Mon, 27 Nov 2023 10:56:12 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1159)
        id 53F8420B74C0; Mon, 27 Nov 2023 10:56:11 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 53F8420B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1701111371;
        bh=/hQV5oGRHVOsT1nJ+jnSk+rrXxrko5nL2UHAuGG2QCA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XNOLUNPbtyk/nFCpL8Y07q99MKH2at5Tda3uA4ZrWS7mg07hZEVN+3BqcV+yhic3C
         UN7vfPSml/4gv9wbhR/HrzwoC8r41kGKxl+YvDSuHznaNE0FhVz4I8E7UFD3uIbodm
         VvkBLgif7So/e+AN9bnCJrlU3pFSjLFjfn76MCWw=
Date:   Mon, 27 Nov 2023 10:56:11 -0800
From:   Nischala Yelchuri <niyelchu@linux.microsoft.com>
To:     Wei Liu <wei.liu@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-fbdev@vger.kernel.org, kys@microsoft.com,
        haiyangz@microsoft.com, decui@microsoft.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, drawat.floss@gmail.com,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org, deller@gmx.de,
        mhklinux@outlook.com, mhkelley@outlook.com,
        singhabhinav9051571833@gmail.com, niyelchu@microsoft.com
Subject: Re: [PATCH] Replace ioremap_cache() with memremap()
Message-ID: <20231127185611.GA27813@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1698854508-23036-1-git-send-email-niyelchu@linux.microsoft.com>
 <ZVFb4f8IRJeCFmYD@liuwe-devbox-debian-v2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVFb4f8IRJeCFmYD@liuwe-devbox-debian-v2>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wei, this is one of the Hyper-V code improvement tasks that Michael Kelley identified.
Using memremap() is the right thing to do here. Abhinav Singh (cc'ed) also
tried to fix this earlier as there are sparse warnings with ioremap_cache().

On Sun, Nov 12, 2023 at 11:12:33PM +0000, Wei Liu wrote:
> On Wed, Nov 01, 2023 at 09:01:48AM -0700, Nischala Yelchuri wrote:
> > Current Hyper-V code for CoCo VMs uses ioremap_cache() to map normal memory as decrypted.
> > ioremap_cache() is ideally used to map I/O device memory when it has the characteristics
> > of normal memory. It should not be used to map normal memory as the returned pointer
> > has the __iomem attribute.
> 
> Do you find any real world issues with the current code? How do you
> discover these issues?
> 
> Thanks,
> Wei.
