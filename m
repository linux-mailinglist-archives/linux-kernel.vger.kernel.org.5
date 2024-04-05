Return-Path: <linux-kernel+bounces-133175-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF656899FF6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CDFAB21A8E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113D416F27E;
	Fri,  5 Apr 2024 14:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="U+wi5+d8"
Received: from mail-ed1-f67.google.com (mail-ed1-f67.google.com [209.85.208.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F360915FA95
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712327994; cv=none; b=LURr5GRysHmPnRgJFYQ10lU6XtzCLIakMiLiQHCkz0BTVsN7hmDyGd3PK5YHdUPOE5siiw1CUdh5eaU9B13u7/EFyPDSWrC+FoiofdMIVhPFy6/J+fg9TxysMqcNqVqTXAkmn+lG5SpvIFo1GlbQANSQfG6iqLYYovw+GoNGVMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712327994; c=relaxed/simple;
	bh=QhEp4IVAU3T9aCAMKtwIVJaACKF0CNAIaYEXbHdVh7s=;
	h=Content-Type:From:Mime-Version:Subject:Date:Message-Id:References:
	 Cc:In-Reply-To:To; b=DvQIeD6xmkHS64TJgu+NBG1QU4HuJY8yVJYG2LqxVrPJhsAZsFZ1lZmii7GXDYOLR2Ug0/NWxhudJXZ267GiD739puJeHAjbYnnE12O20dMXd9WazRS5zlnqhg+Uya9IUNwXIzvGR5c9o59RRXRpFA2D1V2d1+RMZiodOtpHqs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=U+wi5+d8; arc=none smtp.client-ip=209.85.208.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ed1-f67.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so5897436a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1712327990; x=1712932790; darn=vger.kernel.org;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhEp4IVAU3T9aCAMKtwIVJaACKF0CNAIaYEXbHdVh7s=;
        b=U+wi5+d8t4ZiT35au5xh5M/hrB7HEYeO3SVP79FSoI+r2xk2pW4UBldxAWHXcu07ga
         czeFrsu7pOuP727IQp4svDApcVR7DF1LiZBHgQfxOdf7+vGPr708yNzb8raGSD2ZlpZs
         Oxjd1Z/pIX+obkjTReiDZRLyFvdnjSyPnfPY+oNAKX7CBJJeUGH5Wv2sPsjoBN0HcaQK
         0CpCoyLHWn4q89oVmbhWmz7WXAxct/a4T9afqAr2tS11u/EF34W/hPOo8Ivablu5tuLv
         nf/KHy/jrG301Dg2Ey1hprm+URo2JAH43K7aGDiEYPV/Oi03fCL18Dr7AwclOo4hNl0p
         KMCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712327990; x=1712932790;
        h=to:in-reply-to:cc:references:message-id:date:subject:mime-version
         :from:content-transfer-encoding:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QhEp4IVAU3T9aCAMKtwIVJaACKF0CNAIaYEXbHdVh7s=;
        b=uNzUxj7wZr9ySY82yMheSjeVvaa1SoZOl6Oz9wI0R1zxm5bgafeVnlMPnTFOi0MRgq
         tA1bonRIm++IIBwNyFl7UTJncH0KbCPf6kceaJyNGBT7V+Su/Y6W+A9UA65F2/PsYPJ7
         9X49aDHOQy5815Y4MO8ypuRzRlHKRdgu9wN1I4i7hlDbwwBONw6emJ6eg0aG5HRWJ+si
         HHDSbvKbNk5Ip953In4FOgApwajh7Fw06krGQTIHutEzUuqyY6zzf9GbFHd8yhBLgAjL
         4PI9fHpiGaWTUP0B+lm0PwaGIfBAp4r27sknEwLkyh3rET7qeeTYUBRFu1pelUrJuY5V
         L1xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXm6mNwLd1xhoYP0XmWuuCENQWYcUzrr9Xo1ivyIFMe6JmTRlMG6gngi6KZF7vXdff7SZuj2ybNlTfD0YF9q1loxW7MOGk9V1YZTSwV
X-Gm-Message-State: AOJu0YyUH/eA3lrisiApro5ORPAFI+BroCZqZnEl+/fbb4xFbJnKGVrM
	24KJNurfILqCca6P86lGr5kam44xDdZNi3xYcKvKKFY92qU9cmoHrxRwv2u+a7c=
X-Google-Smtp-Source: AGHT+IHEJzjONZERuOpUFdLh9J8dOuHS3DsGn/XOvm6RVLDXMPRnp3Vb0j1GF+ISHZS/+XEMnGU8JA==
X-Received: by 2002:a17:906:53d2:b0:a50:9190:fe51 with SMTP id p18-20020a17090653d200b00a509190fe51mr1850486ejo.3.1712327990208;
        Fri, 05 Apr 2024 07:39:50 -0700 (PDT)
Received: from smtpclient.apple ([37.160.74.118])
        by smtp.gmail.com with ESMTPSA id jy23-20020a170907763700b00a4ea0479235sm901717ejc.107.2024.04.05.07.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 07:39:49 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From: Andrea Cervesato <andrea.cervesato@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (1.0)
Subject: Re: New LTP documentation
Date: Fri, 5 Apr 2024 16:39:38 +0200
Message-Id: <64E6149E-C134-4C8F-AFB8-ECDF7B2B2B46@suse.com>
References: <20240405142219.GA637941@pevik>
Cc: Cyril Hrubis <chrubis@suse.cz>, Jan Stancek <jstancek@redhat.com>,
 Li Wang <liwang@redhat.com>, Xiao Yang <yangx.jy@fujitsu.com>,
 Yang Xu <xuyang2018.jy@fujitsu.com>, Mike Frysinger <vapier@gentoo.org>,
 Alexey Kodanev <aleksei.kodanev@bell-sw.com>,
 Enji Cooper <yaneurabeya@gmail.com>,
 Andrea Cervesato <andrea.cervesato@suse.de>, Wei Gao <wegao@suse.com>,
 Avinesh Kumar <akumar@suse.de>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org, linux-kernel@vger.kernel.org,
 Tim Bird <tim.bird@sony.com>
In-Reply-To: <20240405142219.GA637941@pevik>
To: Petr Vorel <pvorel@suse.cz>
X-Mailer: iPhone Mail (21E236)

Hi Petr,

Thank you very much for the merge!
I hope this is the start for a better project understanding and I also hope c=
ommunity will benefit from this important change.

Thank you Cyril for documenting C API. I=E2=80=99m looking forward to see th=
e remaining ones, I know some of them are already ongoing.

Kind regards,
Andrea Cervesato

> On 5 Apr 2024, at 16:22, Petr Vorel <pvorel@suse.cz> wrote:
>=20
> =EF=BB=BFHi all,
>=20
> today I merged Andrea's and Cyril's work migrating our GitHub based docs t=
o
> readthedocs.org. Andrea, Cyril, thank you for this work, we're now using f=
or
> docs the same approach as the Linux kernel.
>=20
> Our new documentation is now on https://linux-test-project.readthedocs.io/=
en/latest/.
>=20
> I configured the hook on readthedocs.org, thus any docs update should trig=
ger
> readthedocs.org rebuild.
>=20
> I also disabled our wiki on GitHub [2], it redirects to our homepage. It w=
ould
> be good to be able to redirect it to our new readthedocs.org docs [1].
>=20
> I also remove (with Cyril's ack) the content of our github.io page [3] to o=
ur
> new readthedocs.org docs [1].
>=20
> The docs is mostly done, but some bits are missing (e.g. C Test Network AP=
I [4],
> KVM Test API [5], shell API [6]), thus we kept them in doc/old folder. Thi=
s
> folder will be removed once we finish the migration.
>=20
> Kind regards,
> Petr
>=20
> [1] https://linux-test-project.readthedocs.io/en/latest/
> [2] https://github.com/linux-test-project/ltp/wiki/
> [3] https://linux-test-project.github.io/
> [4] https://github.com/linux-test-project/ltp/blob/master/doc/old/C-Test-N=
etwork-API.asciidoc
> [5] https://github.com/linux-test-project/ltp/blob/master/doc/old/KVM-Test=
-API.asciidoc
> [6] https://github.com/linux-test-project/ltp/blob/master/doc/old/Shell-Te=
st-API.asciidoc

