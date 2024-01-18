Return-Path: <linux-kernel+bounces-30433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D88E831E9B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:43:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C93C1F226A5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE182D052;
	Thu, 18 Jan 2024 17:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SN1UImHA"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155C52D04B
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705599789; cv=none; b=XQhkK69LcyztrcwubgBhQtGM5b+nybTRmWNTfg0k8dl6b2jWtQGYhg8gbHfJMN1YdkW8mRPlERqhUngyDSvfTVAwIlY1DoGbCUnbwBCcI0Hvu1eUofxUrQ1eZJ9PK+SMW1/4XqgtclITIwhALADsieraWHbSq//yA8A6XvgH1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705599789; c=relaxed/simple;
	bh=NOcAiExZvR2mQb61dcNah83qN7CavovaR3DLX+XgZEM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NNlj0rAI9ao7ouUbywnpNuNNd0LlEuMqZL+viV8ImqAvg87WFcCmsgflEx1jptjgvigj6U0LHPUjYSym6M6NRO41WdWae4YqasuYJwe16GLNmUHvnjOsyi5ewS9M36q19iB+D8y7nZwXy9ly3pVA4TYkVu93jx9RFYeUf+Xaq78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SN1UImHA; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-553e36acfbaso196a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:43:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705599786; x=1706204586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOcAiExZvR2mQb61dcNah83qN7CavovaR3DLX+XgZEM=;
        b=SN1UImHAfDqvSYWPKQy1ZfJD/O0OqrYawAOLWdjaXsI33a0OrZ+m6cTHzCluqm9zUm
         FnsKIV9rKdjr0ZjVI/ApNjoll7ecdmMT8bJcL+ClyZhCJJ7Y28YCaAA5VsC7hoau4x4w
         hcfeBbh57NaFV0k2K2iSlFbdQB31RwX4QvF1Z3IQwFd4X3fCIINms2uQ815N28E/QqMk
         FA1cZphp957H/lonxnybMC6SoAa/W2x6lWcmbsDgoh2sxy9YU2q00xLj9zQVS3rxctZE
         B5Vb94E3gmky63LaMonlOLRWryGAHlADixLgG5Ndxj4bnCERsAxLlsV8BlEn5dHlw6jh
         UTsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705599786; x=1706204586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NOcAiExZvR2mQb61dcNah83qN7CavovaR3DLX+XgZEM=;
        b=ei33ruKq5faZafUjqE7Q9P3wuPrqX+BfogkZgc7K1B2pozfdMlI+LH+X/+4fUkoZQt
         /yFsYKk0HL74l89t9/rinHRooDP2kFpggave+0HxIX3K8PfMVNV4h0sgj1Fd95kbRNj+
         OVyTT9dzJunqwS3dNxcBeKoODHJaALJK1IF1NLq3F7ffJ/YDNk0wPnKWCq3czMnAdiDH
         Py9HtJrzO4QHbVd0/DsMfrne3Q0Y9GluIHnKzkv/w1E/Y6QrYctWqPVcePbHiY+5c1LY
         WhWgqFGScodYQMlAttnBGvHvRIMcgnXlp76io73mMJfXYXpa9YqUTxC9QQUFuqmZ5GKO
         1hmQ==
X-Gm-Message-State: AOJu0Yy1cBYOK4tLPNTG2RScEt6eJR8Cxh4Zk2HLMtLJTUlp2aK3o84R
	zBv6Yzgk70yE5usP4nLZPheikyjtXaZvKq3smsC6IM9HVK98PSsAZ22pkDTJ2cBDmI+Ks6kYyRr
	4kWv0sQ1f0T6oF0HnJG/Mx13ZB+gkGSxW6WiZ
X-Google-Smtp-Source: AGHT+IE0AakL/4sUeGb+URi8tBIOtgC2fQnSnJWrYDiK2j7xATlq2bUkk4OH1pRcNoFZDynH19IvzdzPXcB0BJXDBJ0=
X-Received: by 2002:a05:6402:b4c:b0:55a:47a0:d8ad with SMTP id
 bx12-20020a0564020b4c00b0055a47a0d8admr63065edb.3.1705599786153; Thu, 18 Jan
 2024 09:43:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240114223532.290550-1-sameo@rivosinc.com> <20240118033515.2293149-1-biao.lu@intel.com>
In-Reply-To: <20240118033515.2293149-1-biao.lu@intel.com>
From: Dionna Amalie Glaze <dionnaglaze@google.com>
Date: Thu, 18 Jan 2024 09:42:50 -0800
Message-ID: <CAAH4kHb9-7p0z2xgmofiCVkOUgXdkJz89qLPc1DuG0F_Wf4-Tg@mail.gmail.com>
Subject: Re: [RFC PATCH v1 0/4] tsm: Runtime measurement registers ABI
To: biao.lu@intel.com
Cc: sameo@rivosinc.com, dan.j.williams@intel.com, linux-coco@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Joerg Roedel <jroedel@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 17, 2024 at 7:36=E2=80=AFPM <biao.lu@intel.com> wrote:
>
> Samuel Ortiz wrote:
> > Some confidential computing architectures (Intel TDX, ARM CCA, RISC-V
> > CoVE) provide their guests with a set of measurements registers that ca=
n
> > be extended at runtime, i.e. after the initial, host-initiated
> > measurements of the TVM are finalized. Those runtime measurement
> > registers (RTMR) are isolated from the host accessible ones but TSMs
> > include them in their signed attestation reports.
> >
> > All architectures supporting RTMRs expose a similar interface to their
> > TVMs: An extension command/call that takes a measurement value and an
> > RTMR index to extend it with, and a readback command for reading an RTM=
R
> > value back (taking an RTMR index as an argument as well). This patch se=
ries
> > builds an architecture agnostic, configfs-based ABI for userspace to ex=
tend
> > and read RTMR values back. It extends the current TSM ops structure and
> > each confidential computing architecture can implement this extension t=
o
> > provide RTMR support.
>
> Hi, Samuel
> The ABI does not include eventlog, but eventlog is usually used with RTMR=
.
> What do you think about how to implement eventlog?
>
>

I had the same question and deleted my reply. The event log in TPM is
made available in sysfs only up to the point that control transitions
to user space. After that, all extensions to PCRs have to be logged by
user space with whatever chosen workload event log representation. I
imagine the same is true for RTMRs.

What this patch series doesn't take into account is how RTMRs might
not be represented in the hardware attestation, but rather would be in
a supervisor service whose integrity is chained from hardware
attestation. In the configfs-tsm model, tsm/report with its single
provider requirement will not be able to interface with the SVSM
attestation protocol /and/ the AMD hardware protocol. That may as well
be okay, but that's a choice folks need to be aware of. There's still
the issue of attesting a single service vs attesting all services in
the SVSM. I imagine single service attestation will have to be
abandoned.

In SVSM, a vTPM is a service that an updated linux driver will be able
to get a quote from, and the same AMD SEV-SNP attestation report TSM
provider would still be present, but if we want a simpler RTMR
service, then we're in a little pickle with this design.

--=20
-Dionna Glaze, PhD (she/her)

