Return-Path: <linux-kernel+bounces-69423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C15978588D4
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 23:37:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D6622815E1
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 22:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554401487E6;
	Fri, 16 Feb 2024 22:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fna6+Ldb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D71152DF0
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 22:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708122792; cv=none; b=TCGLLZnY2HaD0QFHygM5c+4XlYyu1z7fms0qDFxHFmI3ZKPF7Fas8XGJ/wXNHAyRAV+SOBPYYQ4hEs9fIXY0keAXizCDF9f2RJfkpwXagEu1r21RWMjmAI+0fVVbtc7n0KMWwUK444urJxHVCG+puzzbeSXQi5aMSIqYvnO6nw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708122792; c=relaxed/simple;
	bh=LgC+khVEx4YNfPTmqV/PTlnPPsAQXRhZvA6uLp/NpkI=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=D3hIbes6qJBoSUvbK+RDQJFC2JHCc7m9v3y/ytuVRaaL+JAJpCFHBe6XMNPSx8N7oWM48R4wwm39jjIbQtafxTBe0/G0PZsQaBw9AICngT9MAe7lUSEyu4k8cEYVltzSQ+6KUQmGVIdr9LWx+W65x0BZeZiRaxFSFdpeJ3RTpao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fna6+Ldb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708122790;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LgC+khVEx4YNfPTmqV/PTlnPPsAQXRhZvA6uLp/NpkI=;
	b=fna6+LdbTaV49wPW7RzQ+luOJiCSDxE32EdOxoT6+7XwMXT1NuYWp93/aBXZJwjvuD+lL2
	TNJRqssgaaeC50fBQyPrh+iD+4SLw8cc74xnHcOW0IYJEWYNl0dKiZgUc5PhjjZhN4b3Uw
	LXNK76b6wSOYFS1NfFju3DxlJePInt4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-dnJ7jcVAMSOLqazZNE7ODw-1; Fri, 16 Feb 2024 17:33:06 -0500
X-MC-Unique: dnJ7jcVAMSOLqazZNE7ODw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5052D85A58B;
	Fri, 16 Feb 2024 22:33:06 +0000 (UTC)
Received: from [10.2.16.76] (unknown [10.2.16.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EE2BD40C9444;
	Fri, 16 Feb 2024 22:33:05 +0000 (UTC)
Message-ID: <fe234fbbec7f30e34bfc44231b8e061d4ca8dbf4.camel@redhat.com>
Subject: Re: [PATCH] genirq: Wake IRQ threads immediately when changing
 affinity
From: Crystal Wood <crwood@redhat.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Brent Roswell <browsell@redhat.com>
Date: Fri, 16 Feb 2024 16:33:05 -0600
In-Reply-To: <20240122235353.15235-1-crwood@redhat.com>
References: <20240122235353.15235-1-crwood@redhat.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

On Mon, 2024-01-22 at 17:53 -0600, Crystal Wood wrote:
> This avoids a situation where the IRQs are being migrated away from
> an isolated cpu, but the migration does not happen until some arbitrary
> time in the future, causing an isolation disruption.
>=20
> Note that this is of the most benefit on systems where the IRQ affinity
> itself does not need to be deferred to the IRQ handler, but even where
> that's not the case, the total dirsuption will be less.
>=20
> Signed-off-by: Crystal Wood <crwood@redhat.com>

Hi,=C2=A0do you have any thoughts on this patch?

..well, apart from the "dirsuption" typo I just noticed :-P

Thanks,
Crystal


