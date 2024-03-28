Return-Path: <linux-kernel+bounces-123055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6412E890184
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94E661C2A77E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:19:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A420812A14A;
	Thu, 28 Mar 2024 14:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b="JvRFoxnv"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C01683CB2
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635570; cv=none; b=l7Iullqk8WO8RO0m3mOjvemfvCRQiX2Qoz5nOVCfbDTmP0KWlhCD9AXkAMMATaX9btnL2a7R4IskvBW1bPCUhaDMqfuWkVQdu8o/PeJJixX86s+9JjFlWql21RJeg7gKZ8YE2oKvNLwPt/6oD9g0QQzxMUkW6tRQN3ieMPVtCAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635570; c=relaxed/simple;
	bh=/4Q/WXW31g3snYFLHRmqhdEmRrxpqQ2+Fa0Su8cfptw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D8BOlEHuNLx5L5rBs2i/8cD+SEzcF8BSoxVx0Bgc9jirP2EnDdT3CvIxwYdAjwXBsNysRlDA5VoNlmmANU2wxF3Ovt7Ik31ubAFtqlm1uccA9HQ0hfcX507ckfNb6naz7u0+qu/F9fSyA6KtEavxaN3hxmbU0FPZErk2b4PsdRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu; spf=pass smtp.mailfrom=vrull.eu; dkim=pass (2048-bit key) header.d=vrull.eu header.i=@vrull.eu header.b=JvRFoxnv; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=vrull.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vrull.eu
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29df3333d30so784544a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:19:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vrull.eu; s=google; t=1711635569; x=1712240369; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/4Q/WXW31g3snYFLHRmqhdEmRrxpqQ2+Fa0Su8cfptw=;
        b=JvRFoxnv0GmbZvaH5iypllmV449XZ2UOf6+o/6W8q9RHNVn/HuQY1QccLwzI0l005L
         P+F4q2FbFCLu0MlG/3LKi7+32izg38k0WQh3A1TH2GzvoScCON0piRZNDenMncUo/Toi
         yZLlwrlwuv8htBD0oPurB+6jUGpLjDHxaNi63kxH886OHtRuxCuf4EJeVw6kbymOSx8D
         u3mhQVAoqeN7mpRq1zHm2lLbUNkTjc0JTIXe6SVc7FCIF/lxKn0qxCEyR7TjJu+7epCD
         W44KyWUZSzxCqixR9m5k3P9k8jRslXaMjpju1jvHYgOwDvUQE2oG9dK0Y4aCHDy3Bikz
         wHZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635569; x=1712240369;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/4Q/WXW31g3snYFLHRmqhdEmRrxpqQ2+Fa0Su8cfptw=;
        b=RtFtJcGgmTnS6op+V1AD1cMRBIjuZHQyl77TGdIeSJYYbmFUs8Ul4VY97GjQkOqJtK
         wjZwRceQ5LbUEnGRQvEBykpwx50O9w9Fzu/voipeIS2f8V5lGJisQSwrOytDme/8ov9V
         bZ4tUrpQNX0UaLw/EuPkyAY/wkI8kYiMLL8K7OPXQhRfXy193gMQyc6fRyWqXJ1N1e+j
         Y1TkYEANq4DD8UQHE4KU0rQ1vbbCSnRH8FsHPIGEOPTVdM7znGw3kbNlDdCyzqx5Qbpu
         oByWTQQtx5tPEsaJiR5XHpdrS7bBHXrTbIKAk2k1MHZGfuLVdjHlZpjI6GuJnAXo3aZp
         yZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBmWe2STe5xtrpSxVZPOHtY5mjl+QDrl3IaqsmLwZ9r1wTyADH0/3ML10n/32p1FyPE9QDfnvDvPRLh/Y2eeJDHRwxG5d3Pq3K1NkK
X-Gm-Message-State: AOJu0YymVP1A698t0t9lUgwGrB2MUbUq4npwU7oz7XUQu2i2JNbN9Cn/
	vX95/a68uiheqzhx5b9a/I4MqLE6RSCKnm1hKuKeugQp46F8duyMTNCRhuoAJySZpy1vr37OvIq
	sIQH7Che4kzxutu27MPisYpWR5eXizDUytxy5JQ==
X-Google-Smtp-Source: AGHT+IEGkQ0N6UtKBWqxH+7naa+Jluj/ZOxU3Cl+pzh7cHt3uWbZJ1e3TfpyU9qq//m1skCMPh7OVDhYhAzD00yuybQ=
X-Received: by 2002:a17:90a:4a8c:b0:2a0:97a4:8743 with SMTP id
 f12-20020a17090a4a8c00b002a097a48743mr2227314pjh.47.1711635568843; Thu, 28
 Mar 2024 07:19:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327103130.3651950-1-christoph.muellner@vrull.eu> <20240327125954.1809-1-dqfext@gmail.com>
In-Reply-To: <20240327125954.1809-1-dqfext@gmail.com>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Thu, 28 Mar 2024 15:19:17 +0100
Message-ID: <CAEg0e7iFS1C93S4XuhRMQc8oK_kSJ1LMVXHjVcg6bAuUZQfecg@mail.gmail.com>
Subject: Re: [PATCH 0/2] RISC-V: Test th.mxstatus.MAEE bit before enabling MAEE
To: Qingfang Deng <dqfext@gmail.com>
Cc: ajones@ventanamicro.com, alistair.francis@wdc.com, aou@eecs.berkeley.edu, 
	bjorn@kernel.org, conor@kernel.org, cooper.qu@linux.alibaba.com, 
	dbarboza@ventanamicro.com, eric.huang@linux.alibaba.com, heiko@sntech.de, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	palmer@dabbelt.com, paul.walmsley@sifive.com, philipp.tomsich@vrull.eu, 
	zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 2:00=E2=80=AFPM Qingfang Deng <dqfext@gmail.com> wr=
ote:
>
> Hi Christoph,
>
> You don't need the access to MXSTATUS. There is SXSTATUS which is a
> read-only mirror of MXSTATUS in S-mode.

Thanks for the hint!
I'll change the patchsets accordingly (and drop the OpenSBI patchset).

