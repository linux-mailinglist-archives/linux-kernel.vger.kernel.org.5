Return-Path: <linux-kernel+bounces-120133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5436E88D2C5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 00:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5879C1C375BE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:20:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE7F913E04A;
	Tue, 26 Mar 2024 23:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GbaqqkGa"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C428713DDB9
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 23:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711495196; cv=none; b=GSER5DJBO7W95iVyy5AB+f6MHOtHn/wOW6xkRAlfZmJy54/HuEzKDG7rdTcL8beA3BVCqWpGDVBUnrxgrJu77jwKpuOlYHCjXsQ8s2eEs+JLEABU/jRxAG0dmPiekySSV5E+e21LAA7WLwGKTYJJWWljHuRIQcVnSV3TC0yS09U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711495196; c=relaxed/simple;
	bh=xivAcXbXZtZ2lZQPrmwGcUcqzDk/Gs4X/pZkpMagjE4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=dqph+NHJKoYhlruxANppRT/alCeulloVEjYTIpYLiR8lSs79n5lAdgeo9dNH7dH8bJwi4SejLGjexQKUnKU+A5D1lhpU09bEbdVLaB+SrtQUkhyybZfoxZ2tdc1FdRWQRoF3rSG971MKXqy5rpomyKfGJK9BqjPtpWSxyiOnX0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GbaqqkGa; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-609f4155b76so65539677b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711495193; x=1712099993; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xivAcXbXZtZ2lZQPrmwGcUcqzDk/Gs4X/pZkpMagjE4=;
        b=GbaqqkGaYglxdfQV9F0eEIc4+oToxJ1ikU4GjelF3hHZTr+aOA+ylJtr1S46fgeO4f
         gTFJU0GKjBP8gsCnL12i9ELpcxjq3GzmZ9V0FXJFRlj1PvrFIvCg1pXgDZkeVhFxMwwk
         w/D9UOqo8qn0RDxIMNsB10GZ0j//9/mDr9ngij9ouJkRq1y1BfHuKSlvIJE+J5otA+Hv
         jzLg5sVANahBw0BAeSykSy4PNQZploaPHURgdeqblQOYz9yrwP5F18bERToK3Qesyb8C
         3Qs74xfc5uNC5EolYWFn1T9+C5il8fd3lCGsoZ32WLubSW4gmgQxreaunRfWUpMvj0ME
         CIKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711495193; x=1712099993;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xivAcXbXZtZ2lZQPrmwGcUcqzDk/Gs4X/pZkpMagjE4=;
        b=Xo9hShf1RqzzXnTw/NKd6CQROkhkvHZUpZurn5FnYqMhg6VwJjjCqGJa34VSqtgSLI
         4I77qVyblnRLmddot17bdaC+Y5PNvC99Dr36xITj4spX3OpEGTUhJ9xuE+HmxLXsoz8Y
         1jl0P3gZ6aShun2bSgIZoCKcBVCnRbbBYT3NqfcMVNMzWwZA8I/lMrsZsLji1SEH6kup
         lGu5YH78E0dxJCthq3TOIfJ4GsnXgbEtiHUWJUlpuUuL9CY7gctq/T7sxAGwQ/k+6llZ
         zqsroGWuzG3Sn6VQn/oeb6e3F2s1B2B5ItvYgUcWHWwOZsvadxAT7ianhZ98kIHUHOFg
         p7mA==
X-Gm-Message-State: AOJu0Yy++N2q/j1llTNlGDmRHqdC9ry//jJP6rMJqy0Mp6QbINez6GeJ
	kZo9hxVcGbe/Eo1cx6tYbyIWcAGEpu0TShcolDCe1C6cQsxkMerPUpphbaMUqAlrh0oFrVoJ7Wa
	y6Gh6f+SdZeVhOP7pcPonjK6Fo1zwaCz32js=
X-Google-Smtp-Source: AGHT+IFwHnuJaBLb38Gu1ErU73uqJkk2TL1TjYfD6cVMVP7fheWpM6jfBhCtB/7CBPAkNqGmrWLuGxkp46gdnNmTUQ8=
X-Received: by 2002:a25:a4a4:0:b0:dd0:129f:16 with SMTP id g33-20020a25a4a4000000b00dd0129f0016mr8515932ybi.11.1711495193416;
 Tue, 26 Mar 2024 16:19:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chris Rankin <rankincj@gmail.com>
Date: Tue, 26 Mar 2024 23:19:42 +0000
Message-ID: <CAK2bqVLcN3=vmT0t-Cp9VYC0hoGQP6Qevbq40A_8nZ5VNdL2Pw@mail.gmail.com>
Subject: RE: Linux 6.7.11
To: LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

> I'm announcing the release of the 6.7.11 kernel.
>
> All users of the 6.7 kernel series must upgrade.

Hi,

Can you also upload the incremental patches to the usual places
please, for people who only compile their kernels?

https://www.kernel.org/pub/linux/kernel/v6.x/
https://www.kernel.org/pub/linux/kernel/v6.x/incr/

Thanks,
Chris

