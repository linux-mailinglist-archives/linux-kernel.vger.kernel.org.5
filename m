Return-Path: <linux-kernel+bounces-78941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B282C861B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:05:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D58B01C25DDF
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6201713EFEF;
	Fri, 23 Feb 2024 18:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ULrg6GFm"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E296985921
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708711503; cv=none; b=uU1ifmQUPNJoLB0PvKOz/vBhqwraAaeMAoxZfScjDtBWnsn9MGvnQo8DEb1ZO1eFNrrUu3vgY6LaKz8MZdPG+DkWrMzw14qNuvEWQ4JEzNM/dEeIK3XWSQc5/77s6LSQQjAPr8U3pmP/Ujsn4ze0aUTWjWFEsoB1xg8nq3/gdeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708711503; c=relaxed/simple;
	bh=DgRka5e1twI0O1CM4WpP7Yj3tQomnKTgcsf8bQ7aWeQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MLePNxohQ+dJwBEmd3mbCuiJTBnSHMCVXjXkDKKHgoyLN3BeL7e1XW56qAS3kuVRnDqT/8WLz8/f8Wdy614KtULXVLJzczM+Hfo2f7QbV2U5bbIa7xMSlEzamyS3LAsCJC57x6I9Q5TunYsvfOrnWgacBqjaoEGEDNtUFP/nb+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ULrg6GFm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708711500;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=82eigYgjksPkhoX7SASPwd4nqYX8wyhmUpatcdYIcqo=;
	b=ULrg6GFmIRsecZKuhD9lRUdqrPKsbXQvqzy8+4IcxgMQq9zZLHbJ9SdC508dOgL9aZ/dNK
	iKNS746iFGCDQn9VfpeqjmSfMm+OP3rIO/cEaUfEInC/eoikk0aqiFlKFeXbhJiUVbEVgC
	S5R3IqWBKXqF/Li7mwdyIHCteEbE2Ow=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-X61vhmJJN4yGJqh1ZL-hZg-1; Fri, 23 Feb 2024 13:04:58 -0500
X-MC-Unique: X61vhmJJN4yGJqh1ZL-hZg-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33d29de76abso509871f8f.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 10:04:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708711497; x=1709316297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82eigYgjksPkhoX7SASPwd4nqYX8wyhmUpatcdYIcqo=;
        b=htuuOqgESAcerDmwEP/3IsNKxvltZs9dCkE7alU3rOQe1cCYZDBR6TVsDv5Zc/iuEx
         dKqrEHiqLZr63OefpoOmjbAxgcdBiyl4APmKX6sjwQ6glB+w8hbtwt0yGGpIlCaSfwQJ
         6+HRK0jXiXSFWQW+Kp/KAAdRfM1T2uZ2zKgx6DSY4Z+06wIQ8jUcUrkauLugDImi6pVq
         b4KzRzwwwpv1ygUEIj75ZhLcQPX0wcNlT/qG46gpMXREY/7tVrwc0K5sMtqoYjnGFK2R
         R0xVM35KxMrL7tKzeMZpY1deewCf/UZehSLHi7Y73CIJQqEEp7ekJn5lpCBy1m2WLkRE
         tKOw==
X-Gm-Message-State: AOJu0YwaCWoKfqhbg9QlEKiBHRm3lkhtLIZ8h+ZJbP1GkL4+FQWhblDn
	Za2VunCN2xRCs47hXnqj5a0BaxMVH0sdS44ehWdQljlUtmRJj7Fy1NqoZ5efSW2uUH2PLaBf4E1
	b48jjqr2WqKFQmdgPgZi5Skm7A+EWnOInXADXd+COBPVEOzdJIWCkd1oye+MBM7gzoFgYCH9/YL
	ksL4iIKBu3d/QBI/pAyVqXRT6kZm8vpOtgSx3R
X-Received: by 2002:a5d:4c8d:0:b0:33d:3ff4:230e with SMTP id z13-20020a5d4c8d000000b0033d3ff4230emr345335wrs.32.1708711497121;
        Fri, 23 Feb 2024 10:04:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEriJPRAGXbHZuCX1x2uHN2wQ/HGZC16cJxgWCoXazQGUM9K6McAwPYzstWeEsRlKuvvP9dScghPaHqdHGmEyQ=
X-Received: by 2002:a5d:4c8d:0:b0:33d:3ff4:230e with SMTP id
 z13-20020a5d4c8d000000b0033d3ff4230emr345318wrs.32.1708711496805; Fri, 23 Feb
 2024 10:04:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223104009.632194-1-pbonzini@redhat.com> <20240223104009.632194-12-pbonzini@redhat.com>
 <ZdjTTK1TgN8B64zO@google.com>
In-Reply-To: <ZdjTTK1TgN8B64zO@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 23 Feb 2024 19:04:45 +0100
Message-ID: <CABgObfZGWHM414oq3o6YW=KBNytLGdtDThCdmCWLjPUOAutnjA@mail.gmail.com>
Subject: Re: [PATCH v2 11/11] selftests: kvm: add tests for KVM_SEV_INIT2
To: Sean Christopherson <seanjc@google.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, michael.roth@amd.com, 
	aik@amd.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 6:18=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Fri, Feb 23, 2024, Paolo Bonzini wrote:
> > diff --git a/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c b/too=
ls/testing/selftests/kvm/x86_64/sev_init2_tests.c
> > new file mode 100644
> > index 000000000000..644fd5757041
> > --- /dev/null
> > +++ b/tools/testing/selftests/kvm/x86_64/sev_init2_tests.c
> > @@ -0,0 +1,146 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +#include <linux/kvm.h>
> > +#include <linux/psp-sev.h>
> > +#include <stdio.h>
> > +#include <sys/ioctl.h>
> > +#include <stdlib.h>
> > +#include <errno.h>
> > +#include <pthread.h>
> > +
> > +#include "test_util.h"
> > +#include "kvm_util.h"
> > +#include "processor.h"
> > +#include "svm_util.h"
> > +#include "kselftest.h"
> > +
> > +#define SVM_SEV_FEAT_DEBUG_SWAP 32u
> > +
> > +/*
> > + * Some features may have hidden dependencies, or may only work
> > + * for certain VM types.  Err on the side of safety and don't
> > + * expect that all supported features can be passed one by one
> > + * to KVM_SEV_INIT2.
> > + *
> > + * (Well, right now there's only one...)
> > + */
> > +#define KNOWN_FEATURES SVM_SEV_FEAT_DEBUG_SWAP
> > +
> > +int kvm_fd;
> > +u64 supported_vmsa_features;
> > +bool have_sev_es;
> > +
> > +static int __sev_ioctl(int vm_fd, int cmd_id, void *data)
> > +{
> > +     struct kvm_sev_cmd cmd =3D {
> > +             .id =3D cmd_id,
> > +             .data =3D (uint64_t)data,
> > +             .sev_fd =3D open_sev_dev_path_or_exit(),
> > +     };
> > +     int ret;
> > +
> > +     ret =3D ioctl(vm_fd, KVM_MEMORY_ENCRYPT_OP, &cmd);
> > +     TEST_ASSERT(ret < 0 || cmd.error =3D=3D SEV_RET_SUCCESS,
> > +                 "%d failed: fw error: %d\n",
> > +                 cmd_id, cmd.error);
> > +
> > +     return ret;
>
> If you can hold off on v3 until next week, I'll get the SEV+SEV-ES smoke =
test
> series into a branch and thus kvm-x86/next.  Then this can take advantage=
 of the
> library files and functions that are added there.  I don't know if it wil=
l save
> much code, but it'll at least provide a better place to land some of the =
"library"
> #define and helpers.
>
> https://lore.kernel.org/all/20240223004258.3104051-1-seanjc@google.com

I'll post v3 anyway, but hold on actually committing this until I've
taken a closer look at kvm-x86/next.

> > +     TEST_ASSERT(ret =3D=3D -1 && errno =3D=3D EINVAL,
> > +                 "KVM_SEV_INIT2 return code %d, errno: %d (expected EI=
NVAL)",
> > +                 ret, errno);
>
> TEST_ASSERT() will spit out the errno and it's user-friendly name.  I wou=
ld prefer
> the assert message to explain why failure was expected.  That way readers=
 of the
> code don't need a comment, and runners of failed tests get more info.
>
> Hrm, though that'd require assing in a "const char *msg", which would lim=
it this
> to constant strings and no formatting.  I think that's still a net positi=
ve though.

Ok, will do.

>         TEST_ASSERT(ret =3D=3D -1 && errno =3D=3D EINVAL,
>                     "KVM_SET_INIT2 should fail, %s.", msg);
>
> > +     kvm_vm_free(vm);
> > +}
> > +
> > +void test_vm_types(void)
> > +{
> > +     test_init2(KVM_X86_SEV_VM, &(struct kvm_sev_init){});
> > +
> > +     if (have_sev_es)
> > +             test_init2(KVM_X86_SEV_ES_VM, &(struct kvm_sev_init){});
> > +     else
> > +             test_init2_invalid(KVM_X86_SEV_ES_VM, &(struct kvm_sev_in=
it){});
>
> E.g. this could be something like
>
>                 test_init2_invalid(KVM_X86_SEV_ES_VM, &(struct kvm_sev_in=
it){},
>                                    "SEV-ES unsupported);
>
> Though shouldn't vm_create_barebones_type() fail on the unsupported VM ty=
pe, not
> KVM_SEV_INIT2?

Yes, this test is broken. vm_create_barebones_type() errors out.

Paolo


