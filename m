Return-Path: <linux-kernel+bounces-129797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9F689700A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 15:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7965E291498
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 13:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB269148318;
	Wed,  3 Apr 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="U8p0tUqj"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26441482E2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 13:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712150231; cv=none; b=SPJhKJTIGO7AcxlJaK9pAkapLomPrxdJHYu7GVF6UWN7HCT2B3a5TCc07s52EffkCBxuSOuub+/tMV4Rf3E4roW32lxlUpEY6TV9RxgmkHyY5GgAa8antJbaM/9/DiWj7NzvQzlx9sm3LHNetVRA/4+fBPYY9ExYm2+ssp82QJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712150231; c=relaxed/simple;
	bh=bot/LqakO244Ke5ijpewUEVhIF8TPVQB8mcNvJ2IOvE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dtqQLY6OqDAQebIqJhafHiBRqk++lsMH22EmVHU5SJDk7UPvvl0XVP/ngu5THN5/KU8upi+8vR43KHEBJBH3pf0TpJSgVjXTEh5H1kZtODsJQ3ODv8P/rVxM5V1PCeboAQxUOA2o8p98Y1li+KmXlqsUbYUc1pg0bOzFT58O1e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=U8p0tUqj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712150228;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bot/LqakO244Ke5ijpewUEVhIF8TPVQB8mcNvJ2IOvE=;
	b=U8p0tUqjhs+voy334+GtHwfJ73dPNsAHVKF4zbq7n4EgYp52aDx3gr530ycFO33+5IdFgg
	06x+3e1lj8I9QsHRM3NjI2TCJVBtfxnSfQITl7YmQ3ybuLXJlI0xHBBOEm308XJ498y0NN
	7aEcgJC0B0oNazOjIxzlYMwSonWftZ0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-588-YK5XOmpXMaOJLF38S5V0nw-1; Wed,
 03 Apr 2024 09:17:04 -0400
X-MC-Unique: YK5XOmpXMaOJLF38S5V0nw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C9DF1C631C0;
	Wed,  3 Apr 2024 13:17:03 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.197])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CA260C017A0;
	Wed,  3 Apr 2024 13:16:59 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: kuba@kernel.org
Cc: dave.stevenson@raspberrypi.com,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jtornosm@redhat.com,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH net v3] net: usb: ax88179_178a: avoid the interface always configured as random address
Date: Wed,  3 Apr 2024 15:16:33 +0200
Message-ID: <20240403131654.344732-1-jtornosm@redhat.com>
In-Reply-To: <20240402183012.119f1511@kernel.org>
References: <20240402183012.119f1511@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hello Jakub,

You are right, good catch.
For all the cases, the mac address is going to be stored in the chip registers just in case (original behavior), and if the mac address was invalid the first time, a random one will be stored, so that when the mac address is read again from the chip registers will be a locally administered address (random).
I will complete as you say.

Thanks

Best regards
José Ignacio


