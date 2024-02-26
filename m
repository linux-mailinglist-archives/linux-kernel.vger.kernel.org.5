Return-Path: <linux-kernel+bounces-82000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9648867D8E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:09:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E7771F29DE5
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:09:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3C4131E27;
	Mon, 26 Feb 2024 16:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QoXc41Dx"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8879B131748
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708966661; cv=none; b=Oze7mIdTd9icTP8ErPBcfGExa1H7L8TSpb6vxKEU55LQrImGlcxMjPJodJLudQSE9JJwPYlQylnfLPQh3NpX4jOMb30xPYu0xetIgQqwhFjR7FaPuGC3Pm0bHqXo38hL522VvKyHeSx6SzsjHVN7mx0082rT9ULVlJnM7U+nUok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708966661; c=relaxed/simple;
	bh=VmU8eK8zqJHms8skNLek8Ax0OMi+knLlvH0aeWRDWZs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=Cl3lAiK3vOQEk8BREexe/h6z/BOpoFWHIrYqV3YaKh60ldO5z9TdaJvQL8glHppzXL4VFOAMxeRyzv2+s1h9ACR+OrguLJcL23m25rE0tBVH8EOAmAKMWjcIpBlk3Y4DpsdUth1RDa+71+S7jK64njR/ZPj+a53RwNqerux1FJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QoXc41Dx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708966658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=VmU8eK8zqJHms8skNLek8Ax0OMi+knLlvH0aeWRDWZs=;
	b=QoXc41DxK20JcFOmw33R5cjZFs92YhFxUtfEbbVjzbX6CNIqdhJA3tSOHYJjwbUx/BhsgX
	sJbiIOWk1vQ2nhVJwel7IXrbiPY4df3C+ukHF7BbhxKz67K7hCiWGhqm3D5+/8fdB6HuzW
	I2xuMksuwNeavT11r4oh8OuH6L9hYLU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-XA0tXVSlMfemLL_Xbe4GWA-1; Mon, 26 Feb 2024 11:57:35 -0500
X-MC-Unique: XA0tXVSlMfemLL_Xbe4GWA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C68EB185A780;
	Mon, 26 Feb 2024 16:57:34 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.85])
	by smtp.corp.redhat.com (Postfix) with SMTP id 1406E1C14B04;
	Mon, 26 Feb 2024 16:57:32 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 26 Feb 2024 17:56:15 +0100 (CET)
Date: Mon, 26 Feb 2024 17:56:12 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
	Christian Brauner <brauner@kernel.org>,
	Peter Collingbourne <pcc@google.com>,
	Wen Yang <wenyang.linux@foxmail.com>, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] get_signal: minor cleanups and fix
Message-ID: <20240226165612.GA20787@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Wen, as you can see I have changed my mind again ;)

Lets remove this clear_siginfo() right now. It is incomplete (and thus
looks confusing) and unnecessary.

See also 2/3, PF_USER_WORKER's already don't get a fully initialized ksig
anyway.

Do you see anything wrong?

Oleg.


