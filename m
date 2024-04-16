Return-Path: <linux-kernel+bounces-147486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5888A751C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B70C1C227B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 19:51:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AB413958B;
	Tue, 16 Apr 2024 19:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cXkoN3gM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B40513792D
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 19:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713297087; cv=none; b=KNvEVrhnVFcF+jS7fhzI3FbeyqNprDIevXR8fTcGZXsGIshzsjeT2v18XJmZsbZoKxPw6SDgwm0pR3VT4lZqXbn8rwQG7iHBWZqqX7vnmCnFOpGf7nqBauvb5y5XjjX66g0YXcOgL56Jb7FAvRuWzKAuoKYk+KUxKLe3rjlYshc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713297087; c=relaxed/simple;
	bh=3mTUfneJS1zkJu7i86wrjICaNrl6n49Iy2M9Lqe29YU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gg8TZF8NrmO9iWfHd6sloXPtCwZF3oDZVCwnwGjipYFAWOymEGti8UMJTiT8jX0cAK9QY30o5jQp4RMMAC4j59p1P3s2+j6+y54rWi5wSlmypCnRUlaGs3GVzxBjSSloAZanzcHhx7jbhOYWHDBIAafHxELU0vZhjfWwY+cI/KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cXkoN3gM; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713297085;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3mTUfneJS1zkJu7i86wrjICaNrl6n49Iy2M9Lqe29YU=;
	b=cXkoN3gM6i9EuroceyCkvqnxlAqdHCogGyx9S4MrkXVBBb97STJDpS9k5YAMhJm/zqWg+F
	q18VYxnyzLJA0MM6qTf/XTqzjbPKQKwWW7rFCR3U9M8ITy623d1NCaU20nxySTFxPyNHP1
	EHWKkuVfK+67a/bb38q6mIkc/2my7T0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-MN50qXeFONKTFSaO64TEbA-1; Tue, 16 Apr 2024 15:51:23 -0400
X-MC-Unique: MN50qXeFONKTFSaO64TEbA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-343d7cd8f46so3308672f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:51:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713297082; x=1713901882;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3mTUfneJS1zkJu7i86wrjICaNrl6n49Iy2M9Lqe29YU=;
        b=N7Ged1p1La1wesvgMkwZiQGj+kwoffdAajGcu9KFBfN8zzEUDYhH01lptPMoSFkrKB
         +xECK22CrrMEZgxVXb4mEClbhJxJTsa2ICqa1LIRtRYKBFNulHsqyQ4jdge7J7eQ/SFv
         MzcXSsJZcEzCBoVBHOOD4zK7LDCYveQyT68PK4cJiJj/x2/Nui+/xPd98vz9BNigt5Aa
         X7EB1pw9WYa/7mePaIxqgb1LrpyhWSCGjn/abJ1VoPiIx97RmVZoTb4fmG9o97LvGLAy
         v4DDTmCNXsTdYeoYGdKiCdURhXBbhMa1t0+GYJVaoV4b1nPnRlYhLD4lLrVTff8gdXec
         STFw==
X-Forwarded-Encrypted: i=1; AJvYcCV1+TARPtRXVYKS/ghtjqmUthFmRmRPWEdI58MtUZwQdYFlmYzaaCMyR9hFoPJ0Xh4Q4n1R94YBG3eE4z78EaKJF7knSaitiN+P2rcd
X-Gm-Message-State: AOJu0YwbhMkmpDSMpP/Q2w+SIqPciawSJJqUE4zAgtzgIYLBzqJ3TQAS
	ezNYtWVHQ7GUYRONaDSf+JO6dKIk0gR2Co3pVlofQYOo6jVmK3HdU5Cy41fCQlaJ4+QoNZrgUS1
	9bPTxBRiosm0j1hnX+uPYo2Pc4AN+Ewkof572Y++aUwvk379mI2K81t4s48IJEosWtggjEgx6V+
	qx8Z+Q4DGOWY0mcd7fu3QYNrmj4cu60nivymTX
X-Received: by 2002:adf:fb45:0:b0:33e:c924:5486 with SMTP id c5-20020adffb45000000b0033ec9245486mr8796690wrs.46.1713297082633;
        Tue, 16 Apr 2024 12:51:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEp/mk7kynPB1ZucQrsktbYVAslsv0Z/zRq678WnwIH61eiX849fvhBUEvqiB1nNuQwGAypp+Qe8wsMhF+47No=
X-Received: by 2002:adf:fb45:0:b0:33e:c924:5486 with SMTP id
 c5-20020adffb45000000b0033ec9245486mr8796680wrs.46.1713297082266; Tue, 16 Apr
 2024 12:51:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215160136.1256084-1-alejandro.j.jimenez@oracle.com> <Zh6-h0lBCpYBahw7@google.com>
In-Reply-To: <Zh6-h0lBCpYBahw7@google.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 16 Apr 2024 21:51:10 +0200
Message-ID: <CABgObfZ4kqaXLaOAOj4aGB5GAe9GxOmJmOP+7kdke6OqA35HzA@mail.gmail.com>
Subject: Re: [RFC 0/3] Export APICv-related state via binary stats interface
To: Sean Christopherson <seanjc@google.com>
Cc: Alejandro Jimenez <alejandro.j.jimenez@oracle.com>, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, joao.m.martins@oracle.com, 
	boris.ostrovsky@oracle.com, mark.kanda@oracle.com, 
	suravee.suthikulpanit@amd.com, mlevitsk@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 8:08=E2=80=AFPM Sean Christopherson <seanjc@google.=
com> wrote:
>
> On Thu, Feb 15, 2024, Alejandro Jimenez wrote:
> > The goal of this RFC is to agree on a mechanism for querying the state =
(and
> > related stats) of APICv/AVIC. I clearly have an AVIC bias when approach=
ing this
> > topic since that is the side that I have mostly looked at, and has the =
greater
> > number of possible inhibits, but I believe the argument applies for bot=
h
> > vendor's technologies.
> >
> > Currently, a user or monitoring app trying to determine if APICv is act=
ually
> > being used needs implementation-specific knowlegde in order to look for=
 specific
> > types of #VMEXIT (i.e. AVIC_INCOMPLETE_IPI/AVIC_NOACCEL), checking GALo=
g events
> > by watching /proc/interrupts for AMD-Vi*-GA, etc. There are existing tr=
acepoints
> > (e.g. kvm_apicv_accept_irq, kvm_avic_ga_log) that make this task easier=
, but
> > tracefs is not viable in some scenarios. Adding kvm debugfs entries has=
 similar
> > downsides. Suravee has previously proposed a new IOCTL interface[0] to =
expose
> > this information, but there has not been any development in that direct=
ion.
> > Sean has mentioned a preference for using BPF to extract info from the =
current
> > tracepoints, which would require reworking existing structs to access s=
ome
> > desired data, but as far as I know there isn't any work done on that ap=
proach
> > yet.
> >
> > Recently Joao mentioned another alternative: the binary stats framework=
 that is
> > already supported by kernel[1] and QEMU[2].
>
> The hiccup with stats are that they are ABI, e.g. we can't (easily) ditch=
 stats
> once they're added, and KVM needs to maintain the exact behavior.

Stats are not ABI---why would they be? They have an established
meaning and it's not a good idea to change it, but it's not an
absolute no-no(*); and removing them is not a problem at all.

For example, if stats were ABI, there would be no need for the
introspection mechanism, you could just use a struct like ethtool
stats (which *are* ABO).

Not everything makes a good stat but, if in doubt and it's cheap
enough to collect it, go ahead and add it. Cheap collection is the
important point, because tracepoints in a hot path can be so expensive
as to slow down the guest substantially, at least in microbenchmarks.

In this case I'm not sure _all_ inhibits makes sense and I certainly
wouldn't want a bitmask, but a generic APICv-enabled stat certainly
makes sense, and perhaps another for a weirdly-configured local APIC.

Paolo

(*) you have to draw a line somewhere. New processor models may
virtualize parts of the CPU in such a way that some stats become
meaningless or just stay at zero. Should KVM not support those
features because it is not possible anymore to introspect the guest
through stat?

> Tracepoints are explicitly not ABI, and so we can be much more permissive=
 when it
> comes to adding/expanding tracepoints, specifically because there are no =
guarantees
> provided to userspace.
>


