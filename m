Return-Path: <linux-kernel+bounces-33633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91244836C82
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA50287264
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18654B5AB;
	Mon, 22 Jan 2024 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VjBj6HWP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEAB13DB98
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705938808; cv=none; b=uwbJhf0rZDPqNKTH3foWhs2Qb2yeMlVP4IKBVyYeTF0NmadXViRd8Nktn21OK+suXVZDw1eWx8M+6EkYFX18DOvFbBn3yWmZ3YrxtvwkUEWfuRsitQwPeJcS3aJwU18gCqaqbkxat0JBHOLGEt0nNuCPuXf43oQZAMJ+M7Xbztc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705938808; c=relaxed/simple;
	bh=z9ec84LTNQxrzMH3mbPk9MiChnTFnB/bKKQmPAxhz7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aO/TyT+Kw77jQOwKypD5zwKchGyQRH6+H2rin2Ke6iseq9aN0qReQDjy30Lff0pMCFOCxVJDFdr5zIblaz/yi0YBBETMnvuuia/UcvhfNUdMsQtvoAbH+tR+QKbB5A3nrLcC7uYmNlp54cBU/MNSLFaXyV9MoBeeTLKk6OHRf8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VjBj6HWP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705938805;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z9ec84LTNQxrzMH3mbPk9MiChnTFnB/bKKQmPAxhz7c=;
	b=VjBj6HWPIqmCslhO5WwYx2eehEwcXKGktuilfTYiStrklvMnUinNZOeAa56szrCe73zqpv
	xEBZtjJo+G+HNa0C7LTV7LgvJDZC0Ayywccv+HzXPNLWy6zXqFRFC7YAiUlAN9p2S/Tgyd
	9hor6yEA4KKjxd81QKDAWX+8Z2aWmxc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-JWOpoJGAP6W7FtoNqXo_0Q-1; Mon, 22 Jan 2024 10:53:22 -0500
X-MC-Unique: JWOpoJGAP6W7FtoNqXo_0Q-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5C5186D4D4;
	Mon, 22 Jan 2024 15:53:21 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.175])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 52EC85012;
	Mon, 22 Jan 2024 15:53:19 +0000 (UTC)
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
Subject: Re: [PATCH V5 2/2] rpm-pkg: avoid install/remove the running kernel
Date: Mon, 22 Jan 2024 16:53:15 +0100
Message-ID: <20240122155318.13848-1-jtornosm@redhat.com>
In-Reply-To: <CAK7LNARNgp_oYWf69tw4+y0SMp=Hi2rixAt5h8R5=GaMkQLQYA@mail.gmail.com>
References: <CAK7LNARNgp_oYWf69tw4+y0SMp=Hi2rixAt5h8R5=GaMkQLQYA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

> You can proceed with 'rpm -i --force', but
> that is the user's responsibility if something bad happens.

> No, not OK.
Ok, understood and maybe it is interesting for the user.
Indeed, zypper tool from openSUSE can be configured to protect the running
kernel as dnf.
I drop this patch.

Thanks

Best regards
José Ignacio


