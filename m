Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA8D075721E
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 05:18:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231151AbjGRDR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 23:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbjGRDRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 23:17:51 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E9E010C7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:17:50 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-666ecf9a081so5259583b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 20:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689650270; x=1692242270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Yy16q5TeRc5Xpxn792wak9YIx7PrjIz4AMAo6HIm/uU=;
        b=bjzpg/dmrKQ7en4RExJgK2NeBCKWufb1iiQUkwHAA0lKNt876Vaog/+3HYPCXw6TQo
         KdawwsZ2IpbGN2tT2zNMWrUBwIfzf65d55MoA5qhp2Ws3AMdNNCh8ImTBwm0wxIQDWig
         YwXpc3cbvIVwEjsByWJS93dxC6Pva7HCTTG90=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689650270; x=1692242270;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yy16q5TeRc5Xpxn792wak9YIx7PrjIz4AMAo6HIm/uU=;
        b=lLwS6rBw7OuX/rJTiv1Ctd0fYUnpksnLZtCb6gKvNByB/EIWlDacKY88UAFjl3cLnW
         tbgLaSkA9Pp5IRe79VHw/JicOZVVp7/p4WKISfm89VNByMu14OKvp+6OqvifVOamkIj+
         YwLm71iVlhCjwr+MGttFNvPWMmvJNVOmrgCwAYKeIJRq33F7CLV01LxDH6TC3yNZzqks
         xeLkZqhXNUhqqAa3D5PJPe0cB7Huilrnkn6gn3aH+kW96zXy6FNpPwTOQTsmtE5hd3/h
         bXnBnSQp74V/zu8IFIKoMPa1dl09t8yx5MgSjw1Y/Q6nAs2NyM9U0qzF5BqtuIBxtpnw
         xRHA==
X-Gm-Message-State: ABy/qLYbI+olBuzdmFUNIWoDGyj7dUw2P6YETQNgVPaOvQyGhH8NHkkN
        UUj07BYFJWuclRGC4BR7+QU9lPgOpAkS2MCpknw=
X-Google-Smtp-Source: APBJJlF9tK9QhFtIibfhZiESityrKnMVOR6fMYRLQU053J88bZMsild3MUEjSaAv93HeACpG//oAkw==
X-Received: by 2002:a05:6a20:8f11:b0:134:38e5:d146 with SMTP id b17-20020a056a208f1100b0013438e5d146mr8403315pzk.16.1689650269707;
        Mon, 17 Jul 2023 20:17:49 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:49d1:35f7:f76f:e7b1])
        by smtp.gmail.com with ESMTPSA id l12-20020a170903244c00b001b9e9edbf43sm589740pls.171.2023.07.17.20.17.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 20:17:49 -0700 (PDT)
Date:   Tue, 18 Jul 2023 12:17:45 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH printk v3 3/7] printk: Keep non-panic-CPUs out of console
 lock
Message-ID: <20230718031745.GA955071@google.com>
References: <20230717194607.145135-1-john.ogness@linutronix.de>
 <20230717194607.145135-4-john.ogness@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717194607.145135-4-john.ogness@linutronix.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/17 21:52), John Ogness wrote:
> 
> When in a panic situation, non-panic CPUs should avoid holding the
> console lock so as not to contend with the panic CPU. This is already
> implemented with abandon_console_lock_in_panic(), which is checked
> after each printed line. However, non-panic CPUs should also avoid
> trying to acquire the console lock during a panic.
> 
> Modify console_trylock() to fail and console_lock() to block() when
> called from a non-panic CPU during a panic.
> 
> Signed-off-by: John Ogness <john.ogness@linutronix.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
