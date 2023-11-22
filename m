Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C47807F529E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:32:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbjKVVb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:31:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbjKVVbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:31:53 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B6FD46
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:31:49 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-5bd306f86a8so179143a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700688709; x=1701293509; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G58stUSTSALw89pBvbTqM39virdfBZuQa4qBCLmXvF4=;
        b=AKO0Pp6acTiGUl+0vedinOIXM6VHDPj8ei8zSFQYWbOudw23xnQRKGQWbfylLXk01T
         WLmuI3EQdCe8FjH3TzawjI/yV6al3sf0RkWOjmrNPIqPlDIoivfY6kPgnjcogl5gEIfO
         zdh2MRzD/fXQBgDkNkW7dmY3cEOAngpikXR7YcMC1RId+R8WRHD8I0SQE3kdnQpsEAfd
         Q0azpwpPCqRU19xc74flIL8gVCz7mvxqyaL+2gQfpwSlRInaiQZeU+1fBurcKfjo+BAu
         2gzZHyNTmViQ4qQ2l4Mp6RnBS8rsXYNyZOjAE6dquvlVeyjU3hOMJWcnpv+JGAdXtcD7
         2HNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700688709; x=1701293509;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G58stUSTSALw89pBvbTqM39virdfBZuQa4qBCLmXvF4=;
        b=m25yo5JugOFgH0qgNIb8LpA4Rn/tiyQlLMj7VGYRo8a6EiPThCNkN8uztM4ie6crwq
         3KK2PJtwQOLk40AadsF6gZCvxQfYPvGDMzzAF/YtlEAlBbHHD0oSopIVwUO7BQMIJfM7
         mxwL6gY8BrnselSyMUfOlkbh+NfraON658EMDxgHV8U/b8CQIiHdiH4SXw4WAPzV2Mym
         i3Y5iEydR5iG7A/iqhZCkfpwkr20P8i1B/eqRvsR18FFlWDbpYtw+8cUWPQVP+4xo2r1
         zzhZtErjGd4da1z6ppQABTO5l9vPP3xEQO34I1xawvi5RabVO1LPeKkGOe2mP+5mrqGc
         oZgg==
X-Gm-Message-State: AOJu0YydQFRo0DXn64wFkPjv1KpYsQX9JeRvA3mpOwnPNwzOq9EYQxLl
        gvhV79HFslTVL155+OJmFcPu1SJE25A5Ug==
X-Google-Smtp-Source: AGHT+IFAUf1a9x41wwEiV7rwxM2WcFRxArODtcGYUPOtTUJ97n3lPqR8dn6hFqgnr7cBD13nOwqCAg==
X-Received: by 2002:a05:6a21:9982:b0:189:11e8:6237 with SMTP id ve2-20020a056a21998200b0018911e86237mr4128444pzb.51.1700688708683;
        Wed, 22 Nov 2023 13:31:48 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id p14-20020a63f44e000000b005a9b20408a7sm147343pgk.23.2023.11.22.13.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:31:48 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 22 Nov 2023 11:31:47 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Konstantin Khlebnikov <koct9i@gmail.com>,
        Aditya Kali <adityakali@google.com>
Subject: Re: [RFC PATCH v2 1/1] kernfs: replace deprecated strlcpy() with
 strscpy()
Message-ID: <ZV5zQ0gRxzGwweYN@slm.duckdns.org>
References: <20231122212008.11790-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122212008.11790-1-mirsad.todorovac@alu.unizg.hr>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Wed, Nov 22, 2023 at 10:20:10PM +0100, Mirsad Goran Todorovac wrote:
> From: Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>
> 
> According to strlcpy() being officially deprecated and the encouragement
> to remove the remaining occurrences, this came as the intriguing example.
> 
> In the kernfs_name_locked() the behaviour of truncating the kn->name is
> preserved, for it only used in the module for printing in the log and
> declared static. It is only called from pr_cont_kernfs_name() via kernfs_name()
> and returned result is ignored.
> 
> It is avoided to go past the allocated page and cause the internal equivalent
> of SEGFAULT in the unlikely case kn->name is not null-terminated, which I
> believe was the idea behind replacing strlcpy() with strscpy().

I don't follow this line of thinking. Yeah, if the input arguments are
wrong, it can malfunction. strscpy() is gonna page fault too if the input
string crosses into an unmapped page before the destination buffer is
filled, right? But it'd be a stretch to claim that that's a problem with the
function. Maybe I'm missing something but I'm having a hard time seeing the
value in these conversions.

> kernfs_path_from_node_locked() has "(null)" which certainly cannot overrun,
> and a carefully calculated len and truncated path elsewhere.

Some of the functions you're modifying were returning the full length of the
input string before and it isn't clear from the patch or description whether
the conversion is safe. It'd help if you can elaborate more on why the
conversions are safe and how you verified them.

Thanks.

-- 
tejun
