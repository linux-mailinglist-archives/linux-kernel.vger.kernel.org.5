Return-Path: <linux-kernel+bounces-119423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E38588C881
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DD7B3320D88
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 16:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7CD313C918;
	Tue, 26 Mar 2024 16:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TzHSi2AP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DF413C9D4
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 16:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711469157; cv=none; b=qrxdaBDVH0LnbjcGzzOzMggmuQHhECbxBXmjs7yFy5TydX4JJz+r+x8GMToHKiMd7Db2NPWCoI/18ztXpbB7miuHlfEGWAG/+thT9SjbbNDWCD+1V1MB55iOe0Pd1WnWU+ZRqwxwXjYgxvohhx3MrmEyQnfUoUiZgFCzwgtPrMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711469157; c=relaxed/simple;
	bh=VeXxi6qHZQylZGBHh4BKY5FXS27zFr0AFMXg9sxVX2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kwYKi95Mgx1b9wqA5EK1YjXbkOEP3BbrJLfS6lx3+8AXkQ/KoNQnfkkRGY5EePJlEKwpVZtCoKlpdJ/24IB/cvScDV9Mhrf1Ll249EapwL2WhhS6aQewo5J96ZB298tNLGkEbRAmrrGDoLVNzyuYgoKtWSS5TmHZ4HDdrWMFlbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TzHSi2AP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711469154;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k0yFV2iWOWXUGcViPgWX13kSZw6Bw/i9IM+nByXHIb4=;
	b=TzHSi2APgwHU/GYIEjmn7Sj2W2nKqrWroAZQDeAt24uxfLXIgH7ncffWtuuTHNfOKqhgRu
	kkfrhgYnIYH2WmaZ+R4kTyGk2FdWDtDXQeMyDcqP9OsTznu47az7ivbtkoCYGyYZmpaudk
	rbBPLjJqoLeU6XEwFhRL3NIlnNFZL0w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-oIgkKUfwNn6PRb1GdqH7fw-1; Tue,
 26 Mar 2024 12:05:49 -0400
X-MC-Unique: oIgkKUfwNn6PRb1GdqH7fw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AF23D3815EE8;
	Tue, 26 Mar 2024 16:05:48 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.39.193.147])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 0B2782022C1E;
	Tue, 26 Mar 2024 16:05:45 +0000 (UTC)
From: Jose Ignacio Tornos Martinez <jtornosm@redhat.com>
To: horms@kernel.org
Cc: dave.stevenson@raspberrypi.com,
	davem@davemloft.net,
	edumazet@google.com,
	jtornosm@redhat.com,
	kuba@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: Re: [PATCH] net: usb: ax88179_178a: avoid the interface always configured as random address
Date: Tue, 26 Mar 2024 17:05:37 +0100
Message-ID: <20240326160540.224450-1-jtornosm@redhat.com>
In-Reply-To: <20240326092459.GG403975@kernel.org>
References: <20240326092459.GG403975@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Hello Simon,

>> In addition, if mac address can not be read from the driver, a random
>> address is configured again, so it is not necessary to call
>> eth_hw_addr_random from here. Indeed, in this situtatuon, when reset was
>> also executed from bind, this was invalidating the check to configure if the
>> assigned mac address for the interface was random or not.
>
> I also agree with your analysis here. However it does seem to be a separate
> problem. And perhaps warrants a separate patch. I am also wondering
> if this is more of a clean-up than a fix: does it cause a bug
> that is observable by users?
You are right, really it is a separate improvement or simplification.
Right now, it is not affecting the users and it is not producing any
problem, just a second random address is generated if there is any problem,
and this is not necessary, because there is a random address generated
previously.
When the extra reset was done during binding operation, as we were modifying
the pregenerated random address, the check in usbnet_probe was useless.
Ok, I will split the patch in two to be considered separately, the first
with the important fix and the second with the commented improvement or
clean-up. 

> nit: AFAIK, if one arm of a conditional has curly-brackets, then all should.
>     So there is no need to drop them here.
I didn't know the related criteria, I will do as you say.

Thank you

Best regards
José Ignacio


