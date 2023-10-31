Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34E87DCB50
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234942AbjJaLDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbjJaLDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:03:10 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 080F5DF
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 04:03:08 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1698750186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PeHZSGXM4bl+7TvHf+imBwmSlwDpBeiyw/4cbjgQNxE=;
        b=DuNso0CwhDRlRwpk0nAAgLQiMT52Kb+gx5YjPJr/Fa74+asuQCg2Ao0qbr+OGNBVRyWVsj
        gdGQlv8pQAQUnCy/0AeQGMZ1IZYRkwPscrAS9I+u2P0mIs5gv5cuM82cmCoIBJbcGpsfXC
        u39dv374DpeRkrjYtI38jWMFs723FezYlgJhbFhVM5PTxAAvSzOaLZQche/fCkBXAuNErA
        6mgGID7C2Pl1BUeSevGZH72+pcgS2nAX6wjAZTOe9vEcg0sv6Sx8zky4jV6ivAB3oOq2jP
        MfPTLcCpP2sI6TBgElBlNNFOcgC+lQs0s0fFWm4InSEGaTX+cDgyr/HtImjNUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1698750186;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PeHZSGXM4bl+7TvHf+imBwmSlwDpBeiyw/4cbjgQNxE=;
        b=IUZrkxhew3RfrVnGtU7pjhl1RnjJopuKDQL1ZgI1lLafon0o6WodBg+HMjwY2vRy9aWxo1
        QNbAprQpF79Wt5Ag==
To:     Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>,
        Petr Mladek <pmladek@suse.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org,
        Martin =?utf-8?Q?Hundeb=C3=B8ll?= <martin@geanix.com>
Subject: Re: [PATCH 1/2] printk: export pr_flush()
In-Reply-To: <20231030092432.3434623-1-martin@geanix.com>
References: <20231030092432.3434623-1-martin@geanix.com>
Date:   Tue, 31 Oct 2023 12:09:04 +0106
Message-ID: <87h6m7f40n.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-10-30, Martin Hundeb=C3=B8ll <martin@geanix.com> wrote:
> Printk users might want to assure whatever printed has reached its
> destination before continuing. E.g. during the shutdown-procedure, where
> printk-buffers aren't necessarily emptied before the system goes down.

This is reverting:

commit c60ba2d34608 ("printk: Make pr_flush() static")

I agree that it should be exported at some point, but we need to have
outside users.

John Ogness
