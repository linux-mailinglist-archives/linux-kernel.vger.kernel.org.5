Return-Path: <linux-kernel+bounces-58276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 762EC84E3E0
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 16:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1788EB22EBE
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E3137B3C8;
	Thu,  8 Feb 2024 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DPx/exek"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F84076908
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 15:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707405549; cv=none; b=rAQLOByC8kAJUeMdk9LsBvjr3KNhz5PuQgJZkctkhhKdqx213Er/GzNL2wvIL8NQKfrNg/F51DCD2bP8DNDnn0kBa2TTqRPN8+hTK1nymox606ceZLPkZuA98KwQpI7lYBnyHkFN/PrCTUvEpnDpc7Uk+8v75ZNlvxkdpwKgAn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707405549; c=relaxed/simple;
	bh=YaE4rnCUJWx/7Md3/nE4Z3LEbCzPWxX77+ZbszOJLpY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oY/OTt8R8/sPFHJttgmQKb37Vy08SAY7XatUhv522XyTrFhJD2CMHvXJQ3YnLAgUVjtPibGMd4pXsDg1gDiNgsRsG3otVQWhxfe9Zh4vTB8wtX726QhuByfEs1JF1vog4Jxvzg7AE7+PJgjgHRXpsuuqgxpaBTyAxW4+tAlGUkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DPx/exek; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707405546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jC5ELXrvlO45sPj4MDJFCPeH9dCnSddJr5cpxY/vovY=;
	b=DPx/exek860nq2wv3anHhln5r+KmXbt9bVK38bWdv8rfwFK9oMy3TEhnFzvKvFtf2S2wOP
	qpfdUczUTm/n1qmFMtqHhhFHK4isB/mcvktj6qbk2zv16q3j9GkruBuXlru0GDDbuzGkSp
	jCLfNdHAY4zvdI7mQsn92DYqjdCKTlc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-484-BnINLi-cORyHEv3Sqsfo8w-1; Thu, 08 Feb 2024 10:19:04 -0500
X-MC-Unique: BnINLi-cORyHEv3Sqsfo8w-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-68058b0112cso28661016d6.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 07:19:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707405544; x=1708010344;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jC5ELXrvlO45sPj4MDJFCPeH9dCnSddJr5cpxY/vovY=;
        b=jELUE6mqpYYvoMHMN+ZwFsqjRMVxlKQJXcy4lYYncvlSD5ID4lH5SavFsKdOzlkAEj
         bH1TYJ9LBq3jeEowH6IPM4SMOs1kH5wk4aROq62NkzsOdYdMODls4Nq4N/2WrVvpgm2y
         rAoSzn0MceMBiUize3fX2CJ92MrIURgzFmbLIfqLrsC10B9sXyfNi0w5pJUxHJj+ynuV
         ehH1EAu4tcZ+giUS5AglrHm9UVbN3ExFkW/hNP0PwFVbp+KPFzLp9gdGdVRw5fjr20wv
         Ko+7M9ORrTA9HJiG74PzSElCuNVbe6oLWsaUhztl1E1H1h1SpnCDaDb2q8ewgQkJaE2w
         t09Q==
X-Gm-Message-State: AOJu0YzE4/4QY6Z15JCY1WNmA3mB7HcnQ2bEUEyq1GI8oKj6HRnWFs4s
	3UpixRxh4sdtb4q0XGWY3Ytc0yBELTzM6Wj5ZNiAV3ZJhIkq00Vf1V5XXHe8CDOqGsvPPglyEff
	Ur0t0N2s7zVOdIWQ1gsCrDYlQQLArgmHABtF1HdBFckbsHKPDlwjdI2nleibPEQ==
X-Received: by 2002:a0c:f28b:0:b0:68c:cf75:f3ed with SMTP id k11-20020a0cf28b000000b0068ccf75f3edmr312814qvl.36.1707405544123;
        Thu, 08 Feb 2024 07:19:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEPHo2q5+5ap667UZTnNXH7EL+viO7Q3SQ3dk2Fw+Na2aQNXd0SHm24FatVHL7uUZWEREJmdA==
X-Received: by 2002:a0c:f28b:0:b0:68c:cf75:f3ed with SMTP id k11-20020a0cf28b000000b0068ccf75f3edmr312779qvl.36.1707405543881;
        Thu, 08 Feb 2024 07:19:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCX1vzpgWCr3GkZVrTqbWZpqwXV98dgoymDuP6/yj1JYcHSyTcMzDSbdcuymXQAp6RZ5AJ2iJJ37yXibzzcDg1UtvuVKRxS1ah1KaZY9cYQeCu9b+bB3c901lH68PkXBlTseR4itW/SavmR+Xtk6MinI2l1fgjAfswOHPLc8xTzvm8wsVYhR7AHm0s2DdThVX7r+y0AmvPY8YDLgS3sW5uJwaEBKFgnvHDTspFcY1q9Nyg0Gx1rda2sxlOusBSHmX3ARCerFCmPonpwX9l4Owi6MovZAirRUiRzV1Nx/UU25xIvLPMIWikYy+KJbL/MOPXQjinqSzXUs2s+sPHy9TnUm5unxugSKgDC9CmPxpQn22eDy4a2bebK8b2R3QuyRDoO5Kxbky6mXcNalp67WmRezJRhlf0OsHume+V9nu3mqJnawnx+5S1MnYL8JhJ71O8I9D4XEg1LcmR8Bv6clULulmG8HjTXN4U+/C+kZfS2s3BoZ6baMyXf7rjzw1hL4cgdFGLK1EVVEH63ADuDxCytjOH5ZnjzKxPBDX3Mm9o32SI8NDioqaZknh48tFkE+ixi56fdOhOPnavUvAGbbjUJUERdxC46W5jCeS3Rzd4AhsG5DlqGdsPPZdexMxR9ExQOqP/S5VtLH+GckqG0uDkfRldcOJ9Lupb02IRpCSDijfahGljo1YHDwqHbHhK+Tn2I5TSJfSeAcqsM43eY0tMH9oU3Ef56wi/g6pVsmrYBliOp7ePwN/A==
Received: from vschneid-thinkpadt14sgen2i.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id p16-20020ad451d0000000b006862b537412sm73991qvq.123.2024.02.08.07.18.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Feb 2024 07:19:03 -0800 (PST)
From: Valentin Schneider <vschneid@redhat.com>
To: alexs@kernel.org, Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Aneesh Kumar K . V" <aneesh.kumar@kernel.org>, "Naveen N . Rao"
 <naveen.n.rao@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
 <juri.lelli@redhat.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>, Frederic Weisbecker
 <frederic@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Barry Song
 <song.bao.hua@hisilicon.com>, Miaohe Lin <linmiaohe@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>, Srikar Dronamraju <srikar@linux.vnet.ibm.com>, Josh
 Poimboeuf <jpoimboe@kernel.org>, Alex Shi <alexs@kernel.org>, Ricardo Neri
 <ricardo.neri-calderon@linux.intel.com>, Yicong Yang
 <yangyicong@hisilicon.com>, "Gautham R . Shenoy" <gautham.shenoy@amd.com>
Subject: Re: [PATCH v4 5/5] sched: rename SD_SHARE_PKG_RESOURCES to
 SD_SHARE_LLC
In-Reply-To: <20240207035840.936676-1-alexs@kernel.org>
References: <20240207034704.935774-4-alexs@kernel.org>
 <20240207035840.936676-1-alexs@kernel.org>
Date: Thu, 08 Feb 2024 16:18:58 +0100
Message-ID: <xhsmhv86zf0gt.mognet@vschneid-thinkpadt14sgen2i.remote.csb>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On 07/02/24 11:58, alexs@kernel.org wrote:
> From: Alex Shi <alexs@kernel.org>
>
> SD_CLUSTER shares the CPU resources like llc tags or l2 cache, that's
> easy confuse with SD_SHARE_PKG_RESOURCES. So let's specifical point
> what the latter shares: LLC. That would reduce some confusing.
>
> Suggested-by: Valentin Schneider <vschneid@redhat.com>
> Signed-off-by: Alex Shi <alexs@kernel.org>

AFAICT it's just missing the below replacement (I've stretched the comments
to go up to 80 chars while at it), otherwise LGTM.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

---

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index e877730219d38..99ea5986038ce 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -657,13 +657,13 @@ static void destroy_sched_domains(struct sched_domain *sd)
 }
 
 /*
- * Keep a special pointer to the highest sched_domain that has
- * SD_SHARE_PKG_RESOURCE set (Last Level Cache Domain) for this
- * allows us to avoid some pointer chasing select_idle_sibling().
+ * Keep a special pointer to the highest sched_domain that has SD_SHARE_LLC set
+ * (Last Level Cache Domain) for this allows us to avoid some pointer chasing
+ * select_idle_sibling().
  *
- * Also keep a unique ID per domain (we use the first CPU number in
- * the cpumask of the domain), this allows us to quickly tell if
- * two CPUs are in the same cache domain, see cpus_share_cache().
+ * Also keep a unique ID per domain (we use the first CPU number in the cpumask
+ * of the domain), this allows us to quickly tell if two CPUs are in the same
+ * cache domain, see cpus_share_cache().
  */
 DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
 DEFINE_PER_CPU(int, sd_llc_size);


