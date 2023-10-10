Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F2C7C0027
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232439AbjJJPQd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:16:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjJJPQb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:16:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C19AAC;
        Tue, 10 Oct 2023 08:16:28 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696950986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jtkhrz8Wds3YByOny2qieBZFvlhoRSbJRnrkGxOj/8s=;
        b=EA8aO9qtzCtdIIs3RB6R+H+yerguUoA4x7WGlWDVrlar2Ug8XOgXTjssquzdtFavax7YpH
        fGb5RLU9tXldOjNRPt0ACkXrRPf7ndi0Nettuj8lRVBID5GHd3/XyAvJ2LuvpsKBgt7QTd
        ThVSNXVfsRTXeBZrGVQfLmBTqVhBy1m6fv230wmgEpXEFr76o+nBuO0XC3rm8/PUOgrUQ4
        bqmAT8WM4Z6F6s9SmFYbb4VVk/DyA8XJ1yyoH8Qsy8uD0dkrQZEiQTP+xfPm4VJPP9XGIE
        UH7sUr31sk7CKra01QYXudZbtffyi5VzXL4Ly9pwbp4c31lVuvT42z9b7rdbKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696950986;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jtkhrz8Wds3YByOny2qieBZFvlhoRSbJRnrkGxOj/8s=;
        b=6kJnWBMsthzSw/fz7cKfale38tOjGv9DQfrYEvUmRAkRqh0m8GjA7XdsSdWPy2dkNkTQ8C
        aHwy7fhV3sdxaODw==
To:     Biju Das <biju.das.jz@bp.renesas.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     John Stultz <jstultz@google.com>, Stephen Boyd <sboyd@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.au@gmail.com>,
        "linux-rtc@vger.kernel.org" <linux-rtc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: RE: [PATCH v2] alarmtimer: Fix rebind failure
In-Reply-To: <TYCPR01MB11269FF2DBFDC96B9C12D2E5E86CDA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
References: <20230922081208.26334-1-biju.das.jz@bp.renesas.com>
 <87il7fq1al.ffs@tglx>
 <TYCPR01MB112697A5D4B57101CDE27C88D86CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <87fs2jpznr.ffs@tglx>
 <TYCPR01MB11269C6BF3934F9AAC44F855186CEA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
 <87bkd7pic3.ffs@tglx>
 <TYCPR01MB11269FF2DBFDC96B9C12D2E5E86CDA@TYCPR01MB11269.jpnprd01.prod.outlook.com>
Date:   Tue, 10 Oct 2023 17:16:26 +0200
Message-ID: <87o7h6o6d1.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Biju!

On Tue, Oct 10 2023 at 06:18, Biju Das wrote:
> RTC driver is defined as a module, so I was testing
> remove/unbind followed by install/bind on RTC driver to check
> any resource leakage and found that device is not working properly.
>
> As you mentioned above, we should not remove RTC driver. So I would
> like to drop this patch.
>
> Is there any place we can document this to avoid another person doing
> same mistake?

The point is that the removal should not happen in the first place.

Though it seems that even a held refcount on the module is not
preventing that, which is bad to begin with.

That aside I'm not saying that supporting removal is completely
impossible. The charger driver can probably be fixed, but as this is a
user space visible change this needs a lot of thoughts and proper
analysis why such a change would be correct under all circumstances.

Thanks,

        tglx
