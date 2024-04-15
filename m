Return-Path: <linux-kernel+bounces-145340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F268A5303
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 16:24:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9551F227AC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 14:24:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 660A476045;
	Mon, 15 Apr 2024 14:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="BoaMYgfc"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6436C71B32
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 14:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713191031; cv=none; b=q29jVc2yhg/M2pKvIgJGTJ61CTRuMXwo5vFBV8JKkoZ/YDiO+oGowfoaDZDwoDZn2E6YJudGvtUEpgV1tIRVUYr6rsBXcsCwlcHIPXC+I3VAuTTSvNyZI9z871lbhEoYtyHxrDKJ4BOQ32eGLQOOa0OQCIBRi/uJSPM/3np6L2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713191031; c=relaxed/simple;
	bh=DjPumZsJVqQfEW+5UWh6pJFZsGr6TITJM6/HJu6WuT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GE3ZvRf98J95nOXgFShSM3mGSmweBZ4X2FZk/0XiNnV0Hl+tKWAFzfBcNK7V/jh3AcrzbmnI77ySjH23841k8XNzA9hSgf2gDxKfqAI5Qhri5F48A/nK26i8UpCtt85E9ypPTILQWqhytxX+5TgIE8DkgdL91PBVCdEG11bRMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=BoaMYgfc; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6153d85053aso25204967b3.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 07:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1713191029; x=1713795829; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1y9VbcLLmnz0/DZyVAYjkm3SQI/d2qqNn15GQkXprXI=;
        b=BoaMYgfczgaDjoRxhzNAQ7bZ0H8eU+4jlR/fMEGeke6IVqH8nRCIXyx8jo1N7tiWkx
         rNm7o+0QP8Vv21hfqyhbAzOfJ5BLpfFYINqwT8M0hw8wS51H6T43CavRlDl/LJsPa0SO
         Vq2uhxr3fP9KKS6PBOFadLxLD/DuWRlFFeSiQ3SF1137w3MZca4BuEP+tUHuZJfZbaY9
         m0YkttXxHKE1/dz5ytD5XbFx+S06LpjPPwYuJOB5gttVS+E/bglNsNG21No7t5P1TXJu
         z0MYPy5Ftjt7XUv04wzP+A88IOnT7KWsBOy5XNbfjmOjtuo6kOG8R13bxG0nnoU2ay/V
         gVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713191029; x=1713795829;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1y9VbcLLmnz0/DZyVAYjkm3SQI/d2qqNn15GQkXprXI=;
        b=iEpb7kI0wRpZfdvivQfpeANsQYSRKPfTKdqEfvFgqb7AyQB1ZVXmPsLhT2ahsVoNKo
         uAhwIfXgJECXHbaLJnX9lemKx0Hbv0j0rUaRMoPT6MFSIaCZaQweabWd0UsRXRCRIkaw
         T+D+FRPVjoKi9OrRox4hFEVnNORfxF8xXl0aZyGqqUcOWjiNx8v12CSD5KvDZ+46D+dV
         FfyKLhT+DJtlWikpnNlQOD+yCP3PqWGVlmKHznwHgHMCyIEfAWOxKKGPvBq2/B1fE/6X
         9eVsMGlpz7Ye4w+1U8PQCVSXhx+lA/c934giYBDUAe0GNPZU+sjoOoiuW4n4waHPudPE
         VC3Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8MPKaj4ZJ4bjPNuNoFg8Nn+IPtlGZrwZF14Gu8JG32frWyOIsJxpsQpODU98AgUSDx56U2Zln7uZv1ZZwDif7xZ1G2FNaPH0QER/6
X-Gm-Message-State: AOJu0YykEiAQosp3ddb5mTbnTlpNdjtWKYnBuvmCPo21mQzd2YIcRxBd
	GJAQtf8+zu1P2bxvHhILVcfgW5DSL3y8937CA5fio8MydDRiOUGFODjJ1MbqLY7NeK9CI+k9Zc2
	SM7U9Kxs4hLm2+9BEJmnyq1sbolsbVrJ9+MUK
X-Google-Smtp-Source: AGHT+IG5YBGt31zPh1RxDxOyUC/oOmAliyWal5DihWErYrtjx3gqFZi1R7MMZV9pnaXYiGSBEJ7vqkkuCBVCnULk0Vs=
X-Received: by 2002:a0d:dd91:0:b0:614:6b2d:c6f8 with SMTP id
 g139-20020a0ddd91000000b006146b2dc6f8mr8940716ywe.46.1713191029296; Mon, 15
 Apr 2024 07:23:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202404151225.ce542e38-lkp@intel.com> <757538DA-07A4-4332-BAFA-B864BFD06A76@kernel.org>
 <30876b80-c437-4916-b982-97c1a95c0747@I-love.SAKURA.ne.jp>
In-Reply-To: <30876b80-c437-4916-b982-97c1a95c0747@I-love.SAKURA.ne.jp>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 15 Apr 2024 10:23:38 -0400
Message-ID: <CAHC9VhS=hQuvv+Sw6cc2HwzcLApO7Rc3dAnqHytyzBpC1rokFA@mail.gmail.com>
Subject: Re: [kpsingh:static_calls] [security] 9e15595ed0: Kernel_panic-not_syncing:lsm_static_call_init-Ran_out_of_static_slots
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: KP Singh <kpsingh@kernel.org>, kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev, 
	lkp@intel.com, Casey Schaufler <casey@schaufler-ca.com>, Kees Cook <keescook@chromium.org>, 
	Song Liu <song@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 15, 2024 at 9:21=E2=80=AFAM Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
> On 2024/04/15 17:26, KP Singh wrote:
> > This seems like an odd config which does not enable STATIC_CALL, I am g=
oing to
> > make CONFIG_SECURITY depend on CONFIG_STATIC_CALL and make the dependen=
cy explicit.
>
> If CONFIG_SECURITY depends on CONFIG_STATIC_CALL, architectures which do =
not
> support CONFIG_STATIC_CALL can no longer use LSM ? That sounds a bad depe=
ndency.

Agreed.  If the arch doesn't support static calls we need a fallback
solution for the LSM that is no worse than what we have now, and
preferably would still solve the issue of the BPF hooks active even
where this is no BPF program attached.

--=20
paul-moore.com

