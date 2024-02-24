Return-Path: <linux-kernel+bounces-79551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 612BA862402
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:06:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B9982829F9
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:06:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DE261BDD9;
	Sat, 24 Feb 2024 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a86AN6I2"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10F851B965
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 10:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708769207; cv=none; b=XLqY6Pc7ItGAypfwdFr5H9osV70dEZbKeTb1gp8eFwp3UsHNR+2I4Ln2MK9ty+UPWp5c6JUtKZoToOs7dF2W/IRN73qGXPLKFv2eCeEtr1k7WV9W0lzQF2MqJD/2/ob1/Nz//2G4AkZ/362OaSLpmhI1Xa2cGhDeIrOUkOlKt00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708769207; c=relaxed/simple;
	bh=1h8R9grYTeJRg8NpMAYjeeowpOL4cYH4Egz63NDyspk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgERAnCrMNL6/7LVzKJOJToIyR6kHg9i8bjgMn8thXIFqkVuJeOwL20G/q8XdyF7XQneyNjjpTB9b/YYnq5lEpH0m9cpZQpONParLo4dCHMeUVDvzjNvSCMocnHtNTmivCPXHybUTrTw4yS6a7bZKBCiu8ju46fQfhiCtpg10u8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a86AN6I2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708769204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHl18biT5vDkTbpn3heieynPezevOyO3IU67a+gcE40=;
	b=a86AN6I2VmA/NzLVUbxIrTbwptyQ+e24oiB3K2ymmyMMHmsXoMd2Lp8/m4pLXw0icTBC6f
	D5HW+FzC75sx1m8czRU/t2/HAWwJ4ztm7nMg9N9XEqz7otd3OT0lE6hAyfSLGch3RhjMkI
	r2+p+C7OO1iZdrHbxdH02erFfwcfzNk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-512-K1edOm7MObC7lHGK6cY37Q-1; Sat,
 24 Feb 2024 05:06:41 -0500
X-MC-Unique: K1edOm7MObC7lHGK6cY37Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 84F523C0ED77;
	Sat, 24 Feb 2024 10:06:40 +0000 (UTC)
Received: from griffin (unknown [10.45.224.49])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id CF47D492BD7;
	Sat, 24 Feb 2024 10:06:37 +0000 (UTC)
Date: Sat, 24 Feb 2024 11:06:22 +0100
From: Jiri Benc <jbenc@redhat.com>
To: Richard Gobert <richardbgobert@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org,
 amcohen@nvidia.com, petrm@nvidia.com, b.galvani@gmail.com,
 bpoirier@nvidia.com, gavinl@nvidia.com, martin.lau@kernel.org,
 daniel@iogearbox.net, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/2] net: geneve: enable local address bind for
 geneve sockets
Message-ID: <20240224110622.4855a202@griffin>
In-Reply-To: <79a8ba83-86bf-4c22-845c-8f285c2d1396@gmail.com>
References: <df300a49-7811-4126-a56a-a77100c8841b@gmail.com>
	<79a8ba83-86bf-4c22-845c-8f285c2d1396@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

On Thu, 22 Feb 2024 21:53:50 +0100, Richard Gobert wrote:
>  static const struct nla_policy geneve_policy[IFLA_GENEVE_MAX + 1] = {
> -	[IFLA_GENEVE_UNSPEC]		= { .strict_start_type = IFLA_GENEVE_INNER_PROTO_INHERIT },
> +	[IFLA_GENEVE_UNSPEC]		= { .strict_start_type = IFLA_GENEVE_LOCAL6 },

The strict_start_type value should stay at
IFLA_GENEVE_INNER_PROTO_INHERIT. We don't want to relax the strict
checking for that attribute and we want strict checking for the newly
added IFLA_GENEVE_LOCAL.

See the documentation in include/net/netlink.h.

 Jiri


