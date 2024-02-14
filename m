Return-Path: <linux-kernel+bounces-65510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 218C4854DFE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:22:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C29291F22487
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:22:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6111C60256;
	Wed, 14 Feb 2024 16:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IT0uJOoj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456BC60240
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707927756; cv=none; b=bxuuxHhbc2uzP1augq3S3lUjS18j2aEw9WA62GEGnDb7ld5Y7OAo52bvgN0Xg0UXeP8OVfVsaNIzqyOdrXutW5wgLBnPhNOiA/xDK9QNg9Qw3aVIUQVYMFsJpvNneLp1V/QG+8go6bpFaBdwmTD7s9ttBp+0/fb+iO6yXcFwm7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707927756; c=relaxed/simple;
	bh=r+hrK0VyQhwY8SaSExIiwc5DAi+rqAsbqKOce/Igzs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PXmAMq1ADX3yyt68tjSANrsyJKAfq/jxG65mhXNswKwyYcx6HRZ+EsbwCwhP6STMztDVVAw0YmqPmbqLnZMPFMqbSLe8ncVvO4LjxA1lAg/xVJs2aU3S5n+7dsyy+4Ruvr07HNw5VDL4T+GCo0n+enJCI4RutFcZbYOInDeqrTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IT0uJOoj; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707927753;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=r+hrK0VyQhwY8SaSExIiwc5DAi+rqAsbqKOce/Igzs8=;
	b=IT0uJOojlkeKzQ5QJw7EKT1IoVmMPTVxsjLDg9EAcZizZxlUSwdf6rWo8QZdr2WJbQPdNs
	r1Qd6BehEbqNfE3se+TDHCYNYis3n7bsh1qbW8j7VnEPA4myHp1G8brqSEGSHfMo1vnA1b
	FIKcUKdVc+01X6sR3iTckxzahQkAnbw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-XxW0vQoiNEOUGy1KFytB7g-1; Wed, 14 Feb 2024 11:22:32 -0500
X-MC-Unique: XxW0vQoiNEOUGy1KFytB7g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 483408828E7;
	Wed, 14 Feb 2024 16:22:31 +0000 (UTC)
Received: from localhost (unknown [10.39.195.50])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id E64A72166B5E;
	Wed, 14 Feb 2024 16:22:30 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Harald Mommer <Harald.Mommer@opensynergy.com>,
 virtio-dev@lists.oasis-open.org, Haixu Cui <quic_haixcui@quicinc.com>,
 Mark Brown <broonie@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>,
 linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_ztu@quicinc.com, Matti Moell <Matti.Moell@opensynergy.com>, Mikhail
 Golubev <Mikhail.Golubev@opensynergy.com>
Subject: Re: [virtio-dev] [RFC PATCH v3 0/3] Virtio SPI Linux driver
 compliant to draft spec V10
In-Reply-To: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy
 Ross"
References: <20240213135350.5878-1-Harald.Mommer@opensynergy.com>
User-Agent: Notmuch/0.37 (https://notmuchmail.org)
Date: Wed, 14 Feb 2024 17:22:28 +0100
Message-ID: <87v86rf22j.fsf@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

On Tue, Feb 13 2024, Harald Mommer <Harald.Mommer@opensynergy.com> wrote:

> This is the 3rd RFC version of a virtio SPI Linux driver which is
> intended to be compliant with the proposed virtio SPI draft
> specification V10.

FWIW: this version of the SPI spec has been voted in for virtio 1.4 (and
is consequently available on the virtio-1.4 branch of the virtio spec.)
For all intents and purposes, this makes this spec final (modulo
possible future extensions).


