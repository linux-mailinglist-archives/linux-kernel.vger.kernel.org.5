Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA7380EAB7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 12:44:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjLLLn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 06:43:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbjLLLn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 06:43:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81626CD
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 03:44:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C651FC433C8;
        Tue, 12 Dec 2023 11:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1702381443;
        bh=eqmQ3zCBD/6tpWUKuDbGF0pIhxZDCoYVmpZUroAh/4E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lXTgqe/CGqYOqcSZKpN+ibMRTZeXxL3jEOEyGO/OLGNlm+qlJ54pG50vBysl/x5Bt
         emuzBnQiOZEiZHkkO7NKWQNDTQWnxAqFjWP9zcB/noK83P4y2xszhRgD97vShSmR5n
         EbEuX28etV3jsBitC08A+VVPr+CGz6O4NA56ZCrs=
Date:   Tue, 12 Dec 2023 12:44:00 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Daniel Starke <daniel.starke@siemens.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Russ Gorby <russ.gorby@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: Re: [PATCH 5.10 0/3] tty: n_gsm: fix tty registration before control
 channel open
Message-ID: <2023121232-magenta-recall-2cec@gregkh>
References: <20231212111431.4064760-1-Ilia.Gavrilov@infotecs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212111431.4064760-1-Ilia.Gavrilov@infotecs.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:17:21AM +0000, Gavrilov Ilia wrote:
> Syzkaller reports memory leak issue at gsmld_attach_gsm() in
> 5.10 stable releases. The reproducer injects the memory allocation
> errors to tty_register_device(); as a result, tty_kref_get() isn't called
> after this error, which leads to tty_struct leak.
> The issue has been fixed by the following patches that can be cleanly
> applied to the 5.10 branch.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with Syzkaller

Do you actually have any hardware for this protocol running on the
5.10.y kernel?  How was this tested?  Why was just this specific set of
patches picked to be backported?

thanks,

greg k-h
