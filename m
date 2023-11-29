Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28107FD5F5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbjK2Lnf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:43:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjK2Lne (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:43:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDFBCBA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 03:43:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DB2C433C8;
        Wed, 29 Nov 2023 11:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701258220;
        bh=6hxakAmZIQItNkD76sjQSF/47UpUdJ+ouDdRtONsXGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eOggLRELEWXcQMxKJNdbflVMplqVs1d4oSFZVtSvmNNvSIFVTXoEb7tMaarWGgp5n
         SQvQ0XbsjD/9KVI6qacU5DD0JTLkFSmOnHtYDCv91tsumKeJ9kZbdPMqxEgdvYZydf
         TIdUDPKMmjNry2UBwuyoaNuPkkRN0hcNFttoEp8AqxMQAGMB0szOe8vPvuShf0nxCx
         2tqlvm6XWQYYNZrxVdd34UPB+Zt6057uBH88fQzfG3jBIz8CzkI+XjpyJKgqdTpeZx
         QoJfoWXJaxoYtjQbKJXh2WZRTfC+CrQlmAdQlAyuuGt5soT3PtwC5+5ogURFuOxBpV
         weh+Z4iphCbEg==
Date:   Wed, 29 Nov 2023 12:43:36 +0100
From:   Christian Brauner <brauner@kernel.org>
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH/RFC] core/nfsd: allow kernel threads to use task_work.
Message-ID: <20231129-querschnitt-urfassung-3ebd703c345a@brauner>
References: <170112272125.7109.6245462722883333440@noble.neil.brown.name>
 <ZWUfNyO6OG/+aFuo@tissot.1015granger.net>
 <170113056683.7109.13851405274459689039@noble.neil.brown.name>
 <20231128-blumig-anreichern-b9d8d1dc49b3@brauner>
 <170121362397.7109.17858114692838122621@noble.neil.brown.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <170121362397.7109.17858114692838122621@noble.neil.brown.name>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If an nfsd thread only completes the close that it initiated the close
> on (which is what I am currently proposing) then there would be at most
> one, or maybe 2, fds to close after handling each request.  While that
> is certainly a non-zero burden, I can't see how it can realistically be
> called a DOS.

The 10s of millions of files is what makes me curious. Because that's
the workload that'd be interesting.

> > It feels that this really needs to be tested under a similar workload in
> > question to see whether this is a viable solution.
> > 
> 
> Creating that workload might be a challenge.  I know it involved
> accessing 10s of millions of files with a server that was somewhat
> memory constrained.  I don't know anything about the access pattern.
> 
> Certainly I'll try to reproduce something similar by inserting delays in
> suitable places.  This will help exercise the code, but won't really
> replicate the actual workload.
