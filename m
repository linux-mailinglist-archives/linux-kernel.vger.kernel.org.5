Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71B767D1E45
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 18:33:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231572AbjJUQdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 12:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJUQdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 12:33:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ED9B1BF;
        Sat, 21 Oct 2023 09:32:52 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 261F3C433C8;
        Sat, 21 Oct 2023 16:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1697905971;
        bh=J0YExM0i9UyGR28fuSNSuiNULcDD5AwOsLxt/rxGPN0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PdJE3qT4Sz+2st1qtPL0++FJpfbjfyZ1T9tVqqaXeIN0f0JAM94vs+LtZUvZcsFYQ
         i2sA8e6eG4g1IMJIFyEOUDUboczRLoUL+oig1nGVB0pQ/8YK4J/umno0Dwj5r5mCBl
         3nRqMnHJ18/H25w0WNfnrc01BDLIxlofdfkqGK8k=
Date:   Sat, 21 Oct 2023 18:32:48 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org,
        Jiri Slaby <jirislaby@kernel.org>,
        Roger Pau Monne <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Dawei Li <set_pte_at@outlook.com>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, Paul Durrant <paul@xen.org>
Subject: Re: [PATCH v2 1/3] hvc/xen: fix event channel handling for secondary
 consoles
Message-ID: <2023102129-humongous-grant-4576@gregkh>
References: <20231020161529.355083-1-dwmw2@infradead.org>
 <20231020161529.355083-2-dwmw2@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231020161529.355083-2-dwmw2@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 05:15:27PM +0100, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> The xencons_connect_backend() function allocates a local interdomain
> event channel with xenbus_alloc_evtchn(), then calls
> bind_interdomain_evtchn_to_irq_lateeoi() to bind to that port# on the
> *remote* domain.
> 
> That doesn't work very well:
> 
> (qemu) device_add xen-console,id=con1,chardev=pty0
> [   44.323872] xenconsole console-1: 2 xenbus_dev_probe on device/console/1
> [   44.323995] xenconsole: probe of console-1 failed with error -2
> 
> Fix it to use bind_evtchn_to_irq_lateeoi(), which does the right thing
> by just binding that *local* event channel to an irq. The backend will
> do the interdomain binding.
> 
> This didn't affect the primary console because the setup for that is
> special — the toolstack allocates the guest event channel and the guest
> discovers it with HVMOP_get_param.
> 
> Fixes: fe415186b4 ("xen/console: harden hvc_xen against event channel storms")

Nit, our tools complain that the sha1 isn't big enough, "fe415186b43d"
I'll go fix it up...

