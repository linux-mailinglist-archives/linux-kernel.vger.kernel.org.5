Return-Path: <linux-kernel+bounces-87580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D6E386D620
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:25:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED44428B9F9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FB1816FF5F;
	Thu, 29 Feb 2024 21:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZaEgNB8e"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C0F116FF50
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 21:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709241920; cv=none; b=RcBK5b5rP0TRaRQMjkn54339lR9eTFQTToI61COlEx9F4vH937M73YABNA/9joW8+a+12jiPQunfUrsLWwmyveQWBqtyClLeYIpXIo8rNTA7hDhhN6jqOJOU4OFIN9lyXwAcUi7L/xUzwz5GIMJtMr43zU/YUP7cpycufz1WLHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709241920; c=relaxed/simple;
	bh=SFyQlewP4ftbmGqknuUYzFkLWVMDFsCIdPs9JN7A2rk=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=tiLvmwAOgVjdwNUW1sYgTdFDeEqFrSU33TpkYEloaYpxLW1fBbRb1klsJpQJqq0sJQzTK1p+eUWA0oGo6wZxNCgIHETe/1xKJ7lXmeWM+aHUne8xTKHpoMdt+qSyDoKi5ykC6LX53SFdubu/EzTUyfFeFZQQSOFOE1/SS0Ixi4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZaEgNB8e; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709241916;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=c900KPGjnu3D/iFJTCJ5ahUYDipicYnnjvzpvJk+zps=;
	b=ZaEgNB8e+x31AJXFA77IdUS2mF2J+jff6UvqEHG72oXElig55rfBCxVBv7wK7QJ411VcGJ
	PhrOyL3z9jCdu0DrMvAORTCaHJ9ZUe0E/kIN4RDdt8iVauS7yNaH+OVmqzMKTBzFhcer9n
	DCRjysi8RVrVcUFHhowqmGLp/fQNQaU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-EBDQQc53M-m_oYY3F6H75w-1; Thu, 29 Feb 2024 16:25:13 -0500
X-MC-Unique: EBDQQc53M-m_oYY3F6H75w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3D64E881C81;
	Thu, 29 Feb 2024 21:25:13 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.183])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A2F1A112132A;
	Thu, 29 Feb 2024 21:25:12 +0000 (UTC)
Date: Thu, 29 Feb 2024 22:25:10 +0100
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.40-rc2
Message-ID: <20240229212510.ltajnsygpmxclz7i@ws.net.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3


The util-linux release v2.40-rc2 is available at
                                                      
  http://www.kernel.org/pub/linux/utils/util-linux/v2.40/
                                                      
Feedback and bug reports, as always, are welcomed.    
                                                      
  Karel       

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


