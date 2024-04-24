Return-Path: <linux-kernel+bounces-157156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 581C18B0D8D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 17:05:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB8D71F27640
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822E815F32D;
	Wed, 24 Apr 2024 15:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GB7xbFkr"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AC715EFD6
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 15:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713971152; cv=none; b=IjEW2zy4Y4OYx6lXDEThWJKelhN8EoZMWkKN6a+TmZeJVnZOYnz68cXFkpa6piDbSjPxKwreVVFa3rq17TaSQEJr9flctpC66yvHds1UkauQoDjP0M9MDJWlpyIcGG9xPwpFc1dUfezb9RP6lTL95Eezhr8Ew0cQxnv2RTJjhk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713971152; c=relaxed/simple;
	bh=9j2EapAwJRHxx0WCQBfTgCjkDcE9PpTZGoewBtZLYs8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=knx5/SCzFna4HVeupuhSlCDVd4Xd9SGwjiUaQB+0wGntTOraVnH1y9baYQjmDgH2mDU0Sm/fGO3XTUN+DQl1yWVPzW8Ib1TMX7ObGUIvxJ0EZkE1REajL/I/jckKRGE5obuSzv/Kg2pnahbmtCs7oN2FBTkzp7+GKgK8Q3Em3Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GB7xbFkr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713971148;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9j2EapAwJRHxx0WCQBfTgCjkDcE9PpTZGoewBtZLYs8=;
	b=GB7xbFkr5+W/5sijWmQxDFHpTdFsSivHzE/XNX8OfIpUa7iv8wKpMMz0lwiuLtdeV5oH5z
	3LRo0V3XR7Zfb4t4B/Kbhee/6MqSVzfv2l8b5cJn2XUtdIcLEqYRF6GcUKi+BcdY2/ql12
	o0e+7BejVCqZN4rcC1KjcDG7yM76PBA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-CZvzBCBZPQCaoVvysukxuQ-1; Wed, 24 Apr 2024 11:05:41 -0400
X-MC-Unique: CZvzBCBZPQCaoVvysukxuQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2849E104B502;
	Wed, 24 Apr 2024 15:05:40 +0000 (UTC)
Received: from RHTRH0061144 (dhcp-17-72.bos.redhat.com [10.18.17.72])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 9D5E6C13FA3;
	Wed, 24 Apr 2024 15:05:39 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: Jun Gu <jun.gu@easystack.cn>
Cc: pshelar@ovn.org,  dev@openvswitch.org,  netdev@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [ovs-dev] [PATCH net-next] net: openvswitch: Release reference
 to netdev
In-Reply-To: <20240423073751.52706-1-jun.gu@easystack.cn> (Jun Gu's message of
	"Tue, 23 Apr 2024 15:37:51 +0800")
References: <20240423073751.52706-1-jun.gu@easystack.cn>
Date: Wed, 24 Apr 2024 11:05:39 -0400
Message-ID: <f7tbk5yby2k.fsf@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Jun Gu <jun.gu@easystack.cn> writes:

> dev_get_by_name will provide a reference on the netdev. So ensure that
> the reference of netdev is released after completed.
>
> Fixes: 2540088b836f ("net: openvswitch: Check vport netdev name")
> Signed-off-by: Jun Gu <jun.gu@easystack.cn>
> ---

Thanks!

Reviewed-by: Aaron Conole <aconole@redhat.com>


