Return-Path: <linux-kernel+bounces-122742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FED688FC5E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C24451C25B80
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 10:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 220E47B3EB;
	Thu, 28 Mar 2024 10:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TAZ4bAQ/"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3291DFCB
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 10:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711620198; cv=none; b=aIMGZ3VeXKLT3uN1jTTP5pJf9pEd/m4gxLfXfC2pPi4i8YG4BiKuvhmm8U92apU0QXwG9Z+u5FmdcpGpFB+MPhbV+ibgQaSMb/AhhRQgQ7q4woHx+sGJxBiroLbaSdtSG83rEt83XS/P7MgVEOQMnjgrtWefQruMT5lsMKfhXG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711620198; c=relaxed/simple;
	bh=ZC2c6bDSoapIdBgquvXn/MW61rcEJptcjEc3cVlABAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LiW3Jtez3bn3k3D1m4bHSKbUv4mRJN8OCuFLchmb6DRNKn0giaUzXkQ+YYHX0CuAteMJobeXtgm1XjXdyjdti8LbZqhWSMmN7xwA/4lcYTgNQAvteTYz5E4L0PvnW4j3H20zEkx1UlYKcZNP0wPSyRE/sR29tZTp6v6p9tdc5Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TAZ4bAQ/; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a44f2d894b7so88070966b.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 03:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711620194; x=1712224994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wz9jOdEpA4W/9gLrULCqwPBnc5puv/D/qDakXsashEo=;
        b=TAZ4bAQ/B37l/+kUDdWgHh0TQLONxS1h2/UQxmAX5EhM5/9QLKretjgNPJP1cvT9D3
         9JA/WmtTi9K7vDNi+3oc/oP6/mbRnvt48VId3/rJ3k68vQ4Io4w3zj2FCgta+SVD4els
         OQws2vuA7I0xvLxPeu67go2M5dRpHGBJg6+pDA+17qgilUGE3I+KxFFm3enyoBZP9F5r
         erQXGyIM71pZrRJfio111Jc2amA/jnFXDwHUp+mUDVv9W4xRZCAuB8C2OIQ9ZTTqx9Qh
         Ps0nHNkkturkBiZDt6N8G0tiEPaw2tcOg4E5MuqeEHGaD+TIli3SSFGRJxVBL1ZXR/TL
         DZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711620194; x=1712224994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wz9jOdEpA4W/9gLrULCqwPBnc5puv/D/qDakXsashEo=;
        b=b6Y+WvCNXNdZHNa1TyanM2n4DQ4nzvrJh/4A/WKSIEKTr/EbtSfN+OLHiRsQ5Ie/I5
         VFN3+gY9bjC6pAO8eHsisowKxCdVxRGKlnB+Rmjaa7/m5zV/ZAfoOftzyCKml7ROOAT9
         jkfSn14leBczcR9Lm3PsWZCL3VwgXk9QHopdgQ3D/MOkZIytcNCOPE5ROX52bjSYv8ax
         dQkOFu++TpgjnPmW+SfjCTjxLPnQsBY9IUn9ib+30ucGcAEjRMIEm+S6jsFlHaCqFbRe
         dlun59ewgsM+LqR7SmCmbDkl3nG7bq6R5OqfeBaQ+W5lG1S8Md15UMGbDcX9odsK6gsh
         TIBA==
X-Gm-Message-State: AOJu0Yx5d0/8t5GQySZo+0Jik8Ng8+A/FlkKK5uDKIJcmi7Ecq0Z6wD3
	GxXbzkw7Uljgp66ZYcIvNY3lotgYGbdBQSswViUfcfTmgBQWZL+DF+X2ZjzMYI4GMWYbvSvfkP0
	Eqm/pSWH5WRrDnsnuGx9aReYKKBUw91CqVyLINw==
X-Google-Smtp-Source: AGHT+IE/1Utjgtmt3/b/cdHgTg9unxxbGb1RbOhuP2GDqmVLYvZN76y1K/k1lgnPAujiufIeEo+aDgfSACwQyGpFocM=
X-Received: by 2002:a17:906:3c51:b0:a47:61cc:2bf with SMTP id
 i17-20020a1709063c5100b00a4761cc02bfmr1436248ejg.1.1711620194337; Thu, 28 Mar
 2024 03:03:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325035102.15245-1-adrianhuang0701@gmail.com>
 <874jcueydh.ffs@tglx> <CAHKZfL1xq-pemEMo7m8DctEVxSG_ASQWxCC_HsN=-92UAjP_Mw@mail.gmail.com>
 <87h6gsefae.ffs@tglx>
In-Reply-To: <87h6gsefae.ffs@tglx>
From: Huang Adrian <adrianhuang0701@gmail.com>
Date: Thu, 28 Mar 2024 18:03:02 +0800
Message-ID: <CAHKZfL1P+7FyhcYcxjgu7_R2uJAUz38bo1oh68hOYqZgtU73pw@mail.gmail.com>
Subject: Re: [PATCH 1/1] genirq/proc: Try to jump over the unallocated irq
 hole whenever possible
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Jiwei Sun <sunjw10@lenovo.com>, 
	Adrian Huang <ahuang12@lenovo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:36=E2=80=AFAM Thomas Gleixner <tglx@linutronix.de=
> wrote:
>
> > @@ -19,6 +19,10 @@ static void *int_seq_next(struct seq_file *f, void
> > *v, loff_t *pos)
> [ 3 more citation lines. Click/Enter to show. ]
> >         (*pos)++;
> >         if (*pos > nr_irqs)
> >                 return NULL;
> > +
> > +       if (!irq_to_desc(*pos))
> > +               *pos =3D irq_get_next_irq(*pos);
>
> How is irq_get_next_irq() valid without either holding the sparse irq
> lock or RCU read lock?

Indeed, thanks for pointing this out. How about the patch below?

---
diff --git a/fs/proc/interrupts.c b/fs/proc/interrupts.c
index cb0edc7cb..111ea8a3c 100644
--- a/fs/proc/interrupts.c
+++ b/fs/proc/interrupts.c
@@ -19,6 +19,12 @@ static void *int_seq_next(struct seq_file *f, void
*v, loff_t *pos)
        (*pos)++;
        if (*pos > nr_irqs)
                return NULL;
+
+       rcu_read_lock();
+       if (!irq_to_desc(*pos))
+               *pos =3D irq_get_next_irq(*pos);
+       rcu_read_unlock();
+
        return pos;
 }


> But that aside you are missing a massive performance problem in the
> generic show_interrupts() code:
>
>         if (desc->kstat_irqs) {
>                 for_each_online_cpu(j)
>                         any_count |=3D data_race(*per_cpu_ptr(desc->kstat=
_irqs, j));
>         }
>
>         if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
>                 goto outsparse;
>

Yes, good point. The change is shown below.
BTW, I also made the change for iterating each cpu's irq stat. (No
need to check the percpu 'kstat_irqs' pointer for each iteration).

If you're ok, I'll send out the series.

---
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 623b8136e..bfa341fac 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -461,7 +461,7 @@ int show_interrupts(struct seq_file *p, void *v)
 {
        static int prec;

-       unsigned long flags, any_count =3D 0;
+       unsigned long flags, print_irq =3D 1;
        int i =3D *(loff_t *) v, j;
        struct irqaction *action;
        struct irq_desc *desc;
@@ -488,18 +488,28 @@ int show_interrupts(struct seq_file *p, void *v)
        if (!desc || irq_settings_is_hidden(desc))
                goto outsparse;

-       if (desc->kstat_irqs) {
-               for_each_online_cpu(j)
-                       any_count |=3D
data_race(*per_cpu_ptr(desc->kstat_irqs, j));
+       if ((!desc->action || irq_desc_is_chained(desc)) && desc->kstat_irq=
s) {
+               print_irq =3D 0;
+               for_each_online_cpu(j) {
+                       if (data_race(*per_cpu_ptr(desc->kstat_irqs, j))) {
+                               print_irq =3D 1;
+                               break;
+                       }
+               }
        }

-       if ((!desc->action || irq_desc_is_chained(desc)) && !any_count)
+       if (!print_irq)
                goto outsparse;

        seq_printf(p, "%*d: ", prec, i);
-       for_each_online_cpu(j)
-               seq_printf(p, "%10u ", desc->kstat_irqs ?
-                                       *per_cpu_ptr(desc->kstat_irqs, j) :=
 0);
+
+       if (desc->kstat_irqs) {
+               for_each_online_cpu(j)
+                       seq_printf(p, "%10u ",
data_race(*per_cpu_ptr(desc->kstat_irqs, j)));
+       } else {
+               for_each_online_cpu(j)
+                       seq_printf(p, "%10u ", 0);
+       }

        raw_spin_lock_irqsave(&desc->lock, flags);
        if (desc->irq_data.chip) {


-- Adrian

