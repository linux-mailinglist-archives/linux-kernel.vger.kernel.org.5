Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5D37B4F56
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:45:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbjJBJpy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:45:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236216AbjJBJpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:45:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C23FBD;
        Mon,  2 Oct 2023 02:45:50 -0700 (PDT)
Date:   Mon, 2 Oct 2023 11:45:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696239949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3MowVRzXm2YmsrA98gyFla3NvwCXHpDETpA/BOhEMPU=;
        b=gAI7FKDcl7edDdPfBzsFVSpJc34CmE9A+nAyBWxAOAPTtFaYvtU6dPe6TjFh3IK61fI6AU
        yFLYeDKGq4oABD0TmyTJP6tAjciizmVA23pTzFliygN+OKhuj4isj46Oqi/wx5xhY5FGq9
        pAWvJZ2Op8sf8lG4yjSkKEdFA+kIgF3xEhCj8qJY4Qfi18u5cIN1bl1gzmO0NF2OM7aHcf
        Q0bCgm+PBUFMpjvkf14JokGkx1fq3/8rAvoQG1RXNVX7azDY3GBcAy/VarkfsU9uNWYOhF
        3qPX/vGFD2BWVgE65wSiz4AC1gCAd9uHAlaV6nBZ6zGzLelbHbSBB8FPDgFUCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696239949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3MowVRzXm2YmsrA98gyFla3NvwCXHpDETpA/BOhEMPU=;
        b=99oP8AnvLnyr5rF47HaRFQOrD+W0yp/XmL++TI5qSNa4Jlmv58Hqr70lTIliUVnFQAyCby
        HlPX71sSM3K7O3Bw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     "John B. Wyatt IV" <jwyatt@redhat.com>
Cc:     linux-rt-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-rts-sst <kernel-rts-sst@redhat.com>, jlelli@redhat.com
Subject: Re: Crash with 6.6.0-rc1-rt1 and several i915 locking call traces
 with v6.5.2-rt8 and gnome-shell on Alder Lake laptop
Message-ID: <F4pA9qG-zsUd2s-KZZ8oHrbd@linutronix.de>
References: <ZQttJ8W9UFP46E1b@thinkpad2021>
 <20230922110720.AZ03l3A9@linutronix.de>
 <ZRaONA0LSFumpyja@thinkpad2021>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <ZRaONA0LSFumpyja@thinkpad2021>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-29 04:43:32 [-0400], John B. Wyatt IV wrote:
> For stock (non-rt) I do not see it with 6.6-rc2. This was compiled
> with the Stream 9 debug config.
>=20
> I was able to reproduce similar call traces once I tested again
> with 6.6-rc3-rt5 at [4] and [5].
>=20
> What would be the best way to determine if the warning is wrongly
> triggered?

I looked at the traces in this email and they originate from a
might_sleep() in guc_context_set_prio(). The reason is that they check
at the atomic/interrupt state to figure out if they can sleep or not.
Both checks don't work on RT as intended and the former has a not to not
be used in drivers=E2=80=A6

The snippet below should cure this. Could you test, please.

Sebastian


diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc.h b/drivers/gpu/drm/i915/=
gt/uc/intel_guc.h
index 8dc291ff00935..5b8d084c9c58c 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc.h
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc.h
@@ -317,7 +317,7 @@ static inline int intel_guc_send_busy_loop(struct intel=
_guc *guc,
 {
 	int err;
 	unsigned int sleep_period_ms =3D 1;
-	bool not_atomic =3D !in_atomic() && !irqs_disabled();
+	bool not_atomic =3D !in_atomic() && !irqs_disabled() && !rcu_preempt_dept=
h();
=20
 	/*
 	 * FIXME: Have caller pass in if we are in an atomic context to avoid
