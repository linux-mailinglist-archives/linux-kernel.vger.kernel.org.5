Return-Path: <linux-kernel+bounces-125079-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 684888920A8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:41:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3CD7B33B16
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065AE13AA38;
	Fri, 29 Mar 2024 14:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b="sD1wxys6"
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C9B85942;
	Fri, 29 Mar 2024 14:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711720865; cv=none; b=KUiN6urOv4WlOkD5Ua689BbeuxTR3Hu8ZUMIxq0AxmuprJKSHc3coGMbkyOh/tOo35Fu7YCoQnYlg0Uo9fte7opWP8NCzo1U201WOLUfK2FJeJrUhNQNkfzpJVArb+jtvLBImYfwfK5Fa6zhUM1MgQX7+sJyNS/XtxSwodX2XSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711720865; c=relaxed/simple;
	bh=848xYqvHSlvZv4EmGypUnq2Ezo1QbWqY5bjvT/HGv0g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g7uVtA9f6h+aXuTiHZgevChtfEAOjkCF3UKlwTCml+/ottNCii3EqL4fdldG8LcPPSW9WgD3HU1ZBSg5EJSv9g6Kkx/MH4zJWmqQG2ZEomPfTjxFZosBNOXCz8uoXSauLrUVsykk4RKrtjzIswRxqBSBvl9MDjJa5p1jksliXm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de; spf=pass smtp.mailfrom=valentinobst.de; dkim=pass (2048-bit key) header.d=valentinobst.de header.i=kernel@valentinobst.de header.b=sD1wxys6; arc=none smtp.client-ip=212.227.126.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=valentinobst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valentinobst.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=valentinobst.de;
	s=s1-ionos; t=1711720833; x=1712325633; i=kernel@valentinobst.de;
	bh=0tMA2u3w4HmA258Ye88saoMTFiNQAuOCRNaKaxACFf0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=sD1wxys68MJruL41JGvPmGKq91qdw1mq5GA7z8iOwfDd36ZK7kQfmU8oFYQMOB4I
	 A047IKO+2Ps5aPc3W8mi9zMQaeywOVlGfA/ehW2Ux5spjPRjaBydXHxoKp1WCUhNE
	 00TC/kM7vb1lSi9w4HKcFlzlGGU7YkmZIXI1KEl5/gqLEWEniSobcVpRCpyVi9IdR
	 06wiOY3N9iPYfWATgR1fegrJt086OYVeVvYMTE1fR+2f24cVZoslPwIOuTAt/+6Pv
	 vFNBcSGs7jo2whTRpJy7UW4SEGX4esLzmKDeGMJVh0yL3Q6kl3dAryI2M9+KjYg09
	 3hE4chjPxCfijDpFvA==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from archbook.fritz.box ([217.249.70.154]) by
 mrelayeu.kundenserver.de (mreue011 [213.165.67.97]) with ESMTPSA (Nemesis) id
 1MjjOl-1sa14E0ZwJ-00lGU0; Fri, 29 Mar 2024 15:00:33 +0100
From: Valentin Obst <kernel@valentinobst.de>
To: miguel.ojeda.sandonis@gmail.com
Cc: a.hindborg@samsung.com,
	alex.gaynor@gmail.com,
	aliceryhl@google.com,
	benno.lossin@proton.me,
	bjorn3_gh@protonmail.com,
	boqun.feng@gmail.com,
	gary@garyguo.net,
	kernel@valentinobst.de,
	linux-kernel@vger.kernel.org,
	ojeda@kernel.org,
	rust-for-linux@vger.kernel.org,
	walmeida@microsoft.com,
	wedsonaf@gmail.com
Subject: Re: [PATCH v2 0/5] In-place module initialisation
Date: Fri, 29 Mar 2024 15:00:30 +0100
Message-ID: <20240329140030.3989-1-kernel@valentinobst.de>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <CANiq72mkHM3qfq66oDZyZMCuLK8Y1tJxEqFhSYpFWg7ihfcvEA@mail.gmail.com>
References: <CANiq72mkHM3qfq66oDZyZMCuLK8Y1tJxEqFhSYpFWg7ihfcvEA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:q4NjzGhTgNqS2vaM4SlQZAE7CMr8S72aidVH2H2xW52ioXTzxK4
 cxcQWd88Tt8fjhYVtp7OUMM5p0QB0v81pJBqJ437UpexwEjTGonmQCCzhl0b/wg/GcKIiW4
 KqgXAjcxuwYmVuPWbmLmtBgKVIfHZd0foKa/1SaWMdR9cheEN4rofjh+BDZGXDvvYvXpIFX
 njzCCGtJKDH6tlCVVrNyQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:vZSxkjK2pFM=;yHMq3mvBCSS8jCePIb97pS1ScpS
 AS3W/yCGIrcZFiaa4aPIkecMJWuJKPQfBWIZ0cikQXd88S2wc6yfDNPIEGSZMkDHuf/TnPdu4
 0C+W1pHzeMEsAe8E4x9SEuMEwFFUvpH0+Xz0CANThyVMGa0YDMV30XkvcA9AhQ7ZVTdi7+/1C
 LAwGl18TWZwsldy5N6IrWwwCKwhRzYEPmhg5nC1EQJvi/FzNHKLWhi8ZFG/vZIZ3PXh7UkTUC
 xJ4VN4+9ItrbhPIiBLdGgLaFdOqm+Vrk/r075dENsm7yivVIF56u+E9dtMHnmBY34zwtU/0mI
 lARKISM2H2ARDkVEfbNauB06DlDHuNjBqwbeEpihpOaLpc65YGPeeTLi+toqskSqfeB1ISyQU
 6kRTxkZ0qMifElnu8B+5G8hQI2kqT0UBqZ+tnIVyv0BHxROc9Xm/svbyJoGJVxKLL5WhqtJ5P
 cu3qwW7sPMBfYAW9MkWzTWZMFZZlg/dD77URHq/wgHEhPzN+nOjREs64npSSNJqtEvdsRZO6b
 8gH1bNeB6+bnFpZjaUDSdciltQVcCOYhNgeXPIm5nkGg+WH9UlN6tFvqF8U5CqabABX8+sL2t
 d92zNMQOxBZuDpSJmDrstwpPj+ixNGNQZNCSUtQ9BfNXFmIhvJVHJ1N+kNE65AwUYN2/IboIQ
 P0Sb4ZI3M5ibcVucNlZVGGzTRoq3g0cZISTz907FsU2yDOZA3hUdGCOUQNWnkDPnkKbsDKBjr
 AfdAjpZgExZ1irZVFd+hbYSQ6nyEq89ry1VLc44M4CKnrg9Wh7RUi0=

> > I think the idea in [1] was to have this patch being included in the
> > stable trees. I got little experience with stable trees but wouldn't t=
he
> > easiest way be that you add:
> >
> >         Cc: stable@vger.kernel.org # 6.8.x: 715dd8950d4e rust: phy: im=
plement `Send` for `Registration`
> >         Cc: stable@vger.kernel.org
> >         Fixes: 247b365dc8dc ("rust: add `kernel` crate")
> >
> > in the sign-off section for this patch? (Or mark the first one for sta=
ble
> > inclusion as well, [2] has more information on that).
>
> 715dd8950d4e is your local hash for 1/5, right? So I would drop the
> hash, because it may be confusing.

Ah, right, of course this won't be the hash of the commit in mainline;

>
> It may be possible to remove the first line (since 1/5 will only apply
> to 6.8.x and it is already the previous patch in the series, while the

If I interpret the docs correctly, previous patches in the same series are
only implicitly considered as prerequisites for the marked patch if they
are marked themselves:

    "[...] you do not have to list patch1 as prerequisite of patch2
    if you have already marked patch1 for stable inclusion."

So I guess it is important to be explicit.

> `Fixes` tag here may make it clear that 2/5 should still go everywhere
> regardless of 1/5), but I guess it does not hurt to be extra clear.
>
> What about:
>
>     Cc: stable@vger.kernel.org # 6.8.x: rust: phy: implement `Send`
> for `Registration`
>     Cc: stable@vger.kernel.org # 6.1+
>     Fixes: 247b365dc8dc ("rust: add `kernel` crate")

Looks reasonable to me; Also think that the 6.1+ is not striclty necessary
due to the `Fixes` tag though.

    - Best Valentin

>
> Cheers,
> Miguel

