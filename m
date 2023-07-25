Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FACA760CEA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjGYI0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbjGYI00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:26:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84B510CB
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:26:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6EBDF61435
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:26:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48584C433C8;
        Tue, 25 Jul 2023 08:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690273583;
        bh=pwSmx7EakDw8ZwC5qSJyXbGaqWcFUMVP7/xxGtUbCwk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OvSwA0Ra0g1wK080izF1ehdcoJnpoZ+9HVCaJJPcU2Vig+obHIVs6lajxWmYfiJ10
         YHSk2dv7tm2JtcdzgfQGaI0JxFlvh+J95gLynX9HmAY42K9/Q6+zLyGFBqvtbUhDhe
         Dkgx216xuJxdECP+fYsFNyqWB26pAgkl1w9XarLyKd0N/jkaLrYapqKlkbd0dPsbzH
         +Jv69uva004RTuWio1cEqtIfFILdbWmeOY+XYGMSxg6eOm6w0IRmu65sQJNl/5bxY5
         xIrzaQw9KOZFScYO3Ev+2EE+i45/a3A3E1cKGDxHytCDirg63uHt4cgm52Xquskewk
         ioGkHxujaguYA==
Date:   Tue, 25 Jul 2023 10:26:19 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Xuewen Yan <xuewen.yan@unisoc.com>
Cc:     jack@suse.cz, keescook@chromium.org, peterz@infradead.org,
        vincent.guittot@linaro.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com
Subject: Re: [PATCH] pid: Add the judgment of whether ns is NULL in the
 find_pid_ns
Message-ID: <20230725-hemmschwelle-braten-481527898001@brauner>
References: <20230713071713.5762-1-xuewen.yan@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230713071713.5762-1-xuewen.yan@unisoc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 03:17:13PM +0800, Xuewen Yan wrote:
> There is no the judgment of whether namspace is NULL in find_pid_ns.
> But there is a corner case when ns is null, for example: if user
> call find_get_pid when current is in exiting, the following stack would
> set thread_id be null:
> release_task
>     __exit_signal(p);
>         __unhash_process(tsk, group_dead);
>               detach_pid(p, PIDTYPE_PID);
>                   __change_pid(task, type, NULL);
> 
> If user call find_get_pid at now, in find_vpid function, the

I fail to see how this can happen. The code you're referencing is in
release_task(). If current has gone through that then current obviously
can't call find_vpid() on itself anymore or anything else for that
matter.
