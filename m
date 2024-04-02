Return-Path: <linux-kernel+bounces-127612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88143894E63
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA582830C9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2EA57306;
	Tue,  2 Apr 2024 09:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qbfz5iA/"
Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA68A56763
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049164; cv=none; b=K3+acI7ZNV5wNZvD+JSOWT1obhXIrujYGYfmPE++a/wS7atLIgfym+m3c5R76UxCkXeb+aHJyA+cTyb0SF4ttzfIXpy6XE+E3UhFp2ZdQI2ry1Tc4A6C7u8h4Qs2bvxn14f87fXNfBwt7k6RVP/8e8/Ty4Kq7WKt/Hg0GTNzh5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049164; c=relaxed/simple;
	bh=l0kuH/gfbmiikxbhEulmwyHjIEKOY/iskP8dru6n0As=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LpL3Tg2Rjv1BxAkO2JTtD56Mybn++j8UCHzk/Cy1ulR/QaefssteGKrc1Q5dl9uSDti4qlXOYkseavccmVEh23kO7nQABGa1HpaE+C2bB7Rn/X7SrXX87fFlCmqhOGBYlrrKM30TGEGY2vXIKyAKc3gFmu68W3T1WlHHqdMh6ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qbfz5iA/; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-4d8804a553dso1853315e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712049161; x=1712653961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+P752m0UXgMwu+wcLoyQGRKQoJ9RrigTqZcnP7ifrkk=;
        b=qbfz5iA/L/iE1Xx5HuCZFaqpCGDwtQbwN4w6X3ej2oH1J+QV7he5WyJZarq7UxrRje
         CGzH5mPThZZ7k/EjO1r04KwCMljJNRLAz69rHAe3MbiL6LLv0D3MZeyTWgMqB4xOJK/q
         u4DMwN6dFfhOdDu/2ss9yEP13Y0nm+vrmIu5KseC9pgkrQPg1UiMseB4NfRVkx9Nop9J
         EAuKIu5gTaAFZ9+F96zb97RmeYaUC5r3efE04UIXohZHoGI2n8oPikqsELl9/bf6xJ3Z
         6uHmYiyh1w939YBntzKyS3jSRJj/FR+j83Yj47FCaidoRyh0qt/MaxyhAgC82+W3wEV8
         pViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712049161; x=1712653961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+P752m0UXgMwu+wcLoyQGRKQoJ9RrigTqZcnP7ifrkk=;
        b=C++tOqHEFcThRumed+BeWdr+MXUVtiKzj14trIjn7HLf3FRScni82rJpIOMbXmbepW
         mGCA8QP8ycGIN/Gs9fcc7DkuCP9bJLjsj/TtuqFOk/lbZ3BJJHjyJQScvAy8YIrJeHJt
         /9Qfsk/myrbu9TkUL0BuImkOqu9uwErYuLOuAFMZgkOeRdMLHgcyoeI6iFVTbviY9nP9
         RAxzSw2d+GljJ3ZKeOVj9xoKGZEQNPRZeUtkXJhF/ypxTbAVnL4tkQz6cvxzqTNjsNjH
         fH0IlekmXl5itt/zORK0RpL0LBrxFgS7aJkoWmq9mI93UwLJWPWxFKZ26oYOvILxJ+/9
         Yi+A==
X-Forwarded-Encrypted: i=1; AJvYcCVXaKf87j8SoMC2EDum2UIqWwb7ZhZuJVEk2PwabDJTMnjVtwLXCaEI9gsQ2nBra/JEvVFp5qaSr1mmmRNv9pFgfQhUolUY1bFBfyYs
X-Gm-Message-State: AOJu0YwpjtNX38kU887V8ajTbfxFYaML7dgCWIy6C6H2Z+bzCcONwAi3
	HlvRHtdlceyjFLAGT7xA01t/bO8/Bqgi2uTrnwReCL/BNhaQnUiUHeyRGbnXgrUWsiQEXb6KMIo
	wv/oCyV3+fZCNUAUq7xIpYdTw0WsPHX41mjdl8w==
X-Google-Smtp-Source: AGHT+IGOwJVS4tsWfZd+Ju7r2YOHsi//JygXPETSWaASHl0frkCaqLwDK8NaKNahmunxLBxFRjKO4hlQwlv7FcfaS3o=
X-Received: by 2002:a1f:fe4c:0:b0:4d8:37eb:9562 with SMTP id
 l73-20020a1ffe4c000000b004d837eb9562mr7441662vki.0.1712049160602; Tue, 02 Apr
 2024 02:12:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240401152553.125349965@linuxfoundation.org>
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 2 Apr 2024 14:42:29 +0530
Message-ID: <CA+G9fYvc8axBi9Hm_WDac5v-4DiDmiFuKxk=Ghx80obEO9Uknw@mail.gmail.com>
Subject: Re: [PATCH 6.7 000/432] 6.7.12-rc1 review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	linux-kernel@vger.kernel.org, torvalds@linux-foundation.org, 
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org, 
	patches@kernelci.org, lkft-triage@lists.linaro.org, pavel@denx.de, 
	jonathanh@nvidia.com, f.fainelli@gmail.com, sudipm.mukherjee@gmail.com, 
	srw@sladewatkins.net, rwarsow@gmx.de, conor@kernel.org, allen.lkml@gmail.com, 
	broonie@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 1 Apr 2024 at 21:41, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> Note, this will be the LAST 6.7.y kernel release.  After this one it
> will be end-of-life.  Please move to 6.8.y now.
>
> ------------------------------------------
>
> This is the start of the stable review cycle for the 6.7.12 release.
> There are 432 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Wed, 03 Apr 2024 15:24:46 +0000.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
>         https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-=
6.7.12-rc1.gz
> or in the git tree and branch at:
>         git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable=
-rc.git linux-6.7.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

Results from Linaro=E2=80=99s test farm.
Regressions on arm64, arm, x86_64, and i386 with libgpiod tests.

libgpiod test regressions noticed on Linux stable-rc 6.8, 6.7 and 6.6
and Linux next and mainline master.

Anders bisected and found this first bad commit,
  gpio: cdev: sanitize the label before requesting the interrupt
  commit b34490879baa847d16fc529c8ea6e6d34f004b38 upstream.

Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>

LKFT is running libgpiod test suite version
  v2.0.1-0-gae275c3 (and also tested v2.1)

libgpiod
  - _gpiod_edge-event_edge_event_wait_timeout
  - _gpiod_edge-event_event_copy
  - _gpiod_edge-event_null_buffer
  - _gpiod_edge-event_read_both_events
  - _gpiod_edge-event_read_both_events_blocking
  - _gpiod_edge-event_read_falling_edge_event
  - _gpiod_edge-event_read_rising_edge_event
  - _gpiod_edge-event_read_rising_edge_event_polled
  - _gpiod_edge-event_reading_more_events_than_the_queue_contains_doesnt_bl=
ock
  - _gpiod_edge-event_seqno
  - _gpiod_line-info_edge_detection_settings

Test log:
-------
ok 16 /gpiod/edge-event/edge_event_buffer_max_capacity
**
gpiod-test:ERROR:tests-edge-event.c:52:_gpiod_test_func_edge_event_wait_tim=
eout:
'_request' should not be NULL
# gpiod-test:ERROR:tests-edge-event.c:52:_gpiod_test_func_edge_event_wait_t=
imeout:
'_request' should not be NULL
not ok 17 /gpiod/edge-event/edge_event_wait_timeout
ok 18 /gpiod/edge-event/cannot_request_lines_in_output_mode_with_edge_detec=
tion
**
gpiod-test:ERROR:tests-edge-event.c:125:_gpiod_test_func_read_both_events:
'_request' should not be NULL
# gpiod-test:ERROR:tests-edge-event.c:125:_gpiod_test_func_read_both_events=
:
'_request' should not be NULL
not ok 19 /gpiod/edge-event/read_both_events

Links:
 - https://qa-reports.linaro.org/lkft/linux-stable-rc-linux-6.7.y/build/v6.=
7.11-433-gb15156435f06/testrun/23252698/suite/libgpiod/tests/

--
Linaro LKFT
https://lkft.linaro.org

