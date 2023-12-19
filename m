Return-Path: <linux-kernel+bounces-4903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E5888183A2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 09:44:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD0C9283D3F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 08:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AE851170E;
	Tue, 19 Dec 2023 08:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FNKzLMdo"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FC2A14A84
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 08:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702975440;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YrvSxLZe9VcQ9K/emlKRK2E9t4qFRR6zMV18jSkIVOA=;
	b=FNKzLMdoevpWCliScbnK0MDVTqizt2xFyx+bEe4pCuPwa7o4m7cKo2wAFXFPcyXwOh3RKC
	PIB2nZU0UN63WS/vtU27nkPNAmJRC4GYvMXyFmlBzmvkOefi7fd5hSsaS74aCwSQP3KjKW
	0AUlUmCvovi2QKvC0Wqy18efLYyPF2Y=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-675-eA42ncFKN6Ksu-0UYqq83Q-1; Tue,
 19 Dec 2023 03:43:58 -0500
X-MC-Unique: eA42ncFKN6Ksu-0UYqq83Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 197EA280FEC7;
	Tue, 19 Dec 2023 08:43:58 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.165])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 979001121313;
	Tue, 19 Dec 2023 08:43:55 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: masahiroy@kernel.org
Cc: dcavalca@meta.com,
	jtornosm@redhat.com,
	linux-kbuild@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nathan@kernel.org,
	ndesaulniers@google.com,
	nicolas@fjasle.eu,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] rpm-pkg: simplify installkernel %post
Date: Tue, 19 Dec 2023 09:43:50 +0100
Message-ID: <20231219084354.464320-1-jtornosm@redhat.com>
In-Reply-To: <CAK7LNATu-4TSSWpyFyVQYrkS++fUQbfp2tVjEpf3oZBV8ihq8w@mail.gmail.com>
References: <CAK7LNATu-4TSSWpyFyVQYrkS++fUQbfp2tVjEpf3oZBV8ihq8w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Hello Masahiro,

> Fedora ships vmlinux, config, System.map in the module directory.
> Why don't you mimic it?
> Change the %install section to install them to
> /lib/modules/%{KERNELRELEASE}/.
Ok, I did not dare to change a lot of things, overall in other sections.
I like the idea of imitating Fedora and making it easier.

> Then, change %post section to copy them to /boot/.
> If you take care of an unusual case where installkernel
> is not found, you can support manual copy as a fallback.
Ok, much clear in this way (and independent of software packages).
Again, good idea.

> Maybe, you can also convert the installkernel syntax to
> kernel-install while you are here.
Ok, that tool is more complete, I will try.

The next version will include all of this.

Thank you

Best rgards
José Ignacio


