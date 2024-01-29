Return-Path: <linux-kernel+bounces-42452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30838840182
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:29:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26321F26FA6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:29:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3248655E68;
	Mon, 29 Jan 2024 09:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGIyFfbZ"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3E5055790
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706520456; cv=none; b=baz27VsADwMrlzioW2VT+mf4IvqHlZscOYnga5d1oz3uR2LKWN997xk9MrIaELcsJxkjUaebJ1PZ1SVUbzIrZefzSJUJmiUs4w/KwyvPtuTj4YdsXfTCQa/94vA+Hxkdhnbhc2NPYz9QWqO6MKr4qKEKL7Ksr66QKbYfvorHxzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706520456; c=relaxed/simple;
	bh=hn9qNS4wUmMn0/IedVdqEWa8YsnO8548Biok/rcVaBY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sqAUirHpSL4A1kQUWy4mIVreZM0Wny9ai+t11dMKZz8nsZzzcxudWYw2T1tZbGEvTfc9/vwYHOjhmMecCE69iRii+JbtNK3WLfNgLC0KCLmM2onBkLnEmTTRqZ2g7N6P/fQbnl9mEYJ4/KUHgRrxgAed25wQ76e38wk2Zmzn9gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VGIyFfbZ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706520454;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hn9qNS4wUmMn0/IedVdqEWa8YsnO8548Biok/rcVaBY=;
	b=VGIyFfbZKwUScI7tiNKWbgBMqHSYffnwW19m1T2W4QfbS1Zf6zyUdS2ZgYKsIV6DBYlWvs
	DYLbHmsxcdK1N2Ryd4kBXIN8Xzt5nLtezQfaj9d44SwbxWWy9P+3njvqkoCaHBIAiPGGnq
	pRfn0Mst140Vka+CiNi4Op+tATK5ZDQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-615-cfSRzuhYOGiFnYj4rDjiTA-1; Mon,
 29 Jan 2024 04:27:28 -0500
X-MC-Unique: cfSRzuhYOGiFnYj4rDjiTA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F01D61C05EB5;
	Mon, 29 Jan 2024 09:27:27 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.192.173])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7C876111E6;
	Mon, 29 Jan 2024 09:27:25 +0000 (UTC)
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
Subject: Re: [PATCH] rpm-pkg: simplify installkernel %post
Date: Mon, 29 Jan 2024 10:27:20 +0100
Message-ID: <20240129092724.10064-1-jtornosm@redhat.com>
In-Reply-To: <CAK7LNAR2xDjbn+BZqUrgbDxPJUyQBULFB51kTiN8Nc78DXVyEw@mail.gmail.com>
References: <CAK7LNAR2xDjbn+BZqUrgbDxPJUyQBULFB51kTiN8Nc78DXVyEw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Ok, I will simplify the check to copy as you say (cpm --silent returns
error if file doesn't exist) and and I will limit the indentation to the
modifications.
If you are going to modify the rest, I think other style changes are not
necessary.

Thanks

Best regards
José Ignacio


