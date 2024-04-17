Return-Path: <linux-kernel+bounces-148174-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CC178A7EAD
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:52:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E11B1F22DCC
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C24E012C467;
	Wed, 17 Apr 2024 08:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KI/92vF+"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99FC7E0E4
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713343922; cv=none; b=ZEyA4TBCo3pvFQ6l0Yq3fp7jDuF15m52W+Ts3zjQSn770VA9jtbSOuHB/p6LrKISPUduf/B2UCRwDMdIZyVCML98A67kb6p5cx1BHZV1jfyuY1kqL9KiN9Kspb43bxz/Gr07IouWSI9tu0bkZmMnZTvF6eNkEvfwisnQbA6D4xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713343922; c=relaxed/simple;
	bh=nLrkFEe4Sr4UShI8ScNIyCYxlUJPK0uRjdjp8ONRmus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S40urwyChCei2J5NU0yGZnwRL/ve2H3rf3vfy9jYTxzA4DPGMPl4X2RomEgYotSa1vPhmqW5LWrBzW1+NIR1gNceu6C/JI5HpijXxkSa17pnO2bU8DyFi8rrFP4CXY+g2anvLyCw0CO5a2hGhQhLC47SevlHx+sq1u0y0tl7G/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KI/92vF+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713343919;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dVPyrvg8jq+Af1WjENtNQaFsERndNa/U+D0gRrpnkiw=;
	b=KI/92vF+es5lZapOLf716WiCVPaGiY9wbs3fzijUCG2vxCAv6bA0DOfuIiWpJcKj3ogdEu
	02DSTLxyMRahb23/Di+253wOmkiFJZ5y692urjukiU63mGxI8cu6A8ALLMtT5F9upERyXD
	lSFQEqg3VxNABdrou5r3WTUHR33XTkE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-438-MHldD08jNa-ffleAeYaAPw-1; Wed,
 17 Apr 2024 04:51:54 -0400
X-MC-Unique: MHldD08jNa-ffleAeYaAPw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 764F028EC11B;
	Wed, 17 Apr 2024 08:51:53 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.59])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 86208C0157D;
	Wed, 17 Apr 2024 08:51:50 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	jarkko.palviainen@gmail.com,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: ax88179_178a: avoid writing the mac address before first reading
Date: Wed, 17 Apr 2024 10:51:42 +0200
Message-ID: <20240417085145.219405-1-jtornosm@redhat.com>
In-Reply-To: <20240415104802.6765bcdb@kernel.org>
References: <20240415104802.6765bcdb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hello Jakub,

My intention was to simplify it and reduce the delays, because two
consecutive resets were used at initialization, one from bind (the one
initially called during probe) and one from open.
Indeed my initial idea was to let the one from bind/probe only but reset
operation had to be removed from driver_info and that is the reason why 
the one from open was choosen.
But the one from bind/probe is better in order to avoid the commented
issue. Let me try with this in a second version.

Thank you again

Best regards
José Ignacio


