Return-Path: <linux-kernel+bounces-166728-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7448B9E96
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26266B23DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3FFC16C444;
	Thu,  2 May 2024 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b="rhNipQEd"
Received: from mx.treblig.org (mx.treblig.org [46.235.229.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC437211C
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 16:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.229.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714667456; cv=none; b=mqttUKy0tjfklWlJA4tUcudIScepVfdu7o4QAF1SCinca+5ZJqzD3BA3s7muDrQkDtaAYTZZAk7s3UrAvVJ3Dbb1sQXFSJPNAR94NEAGw2QwsB39+B8VGbVWIOwMAZ9/9UBzvHfaR9cCbyIZYbOqiqX90/n/BlRJPVmYasRso9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714667456; c=relaxed/simple;
	bh=FDs8zOxUdfobTpJKR/H15bW4BvIDRf4R69hj+7xfUXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ezdHOhAhUZFOwhX17zuH3gFvaSbg/pdP25WOdgJtxYOdtoEDYYQUqJO3b4dHyBAw35QjVxhaHQoiHXZU4/5x/Mxm9peQ91pg2zfL4FUakNXgjAIkrHKQuSjjWaH9EVf6DCJspva49DaZYWe9Ujy9NAmdnqDiUh8qwDv4ALi0Ngs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org; spf=pass smtp.mailfrom=treblig.org; dkim=pass (2048-bit key) header.d=treblig.org header.i=@treblig.org header.b=rhNipQEd; arc=none smtp.client-ip=46.235.229.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=treblig.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=treblig.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
	; s=bytemarkmx; h=MIME-Version:Message-ID:Date:Subject:From:Content-Type:From
	:Subject; bh=VF57B/xw0oUlWQRex3Gc5BwlwzzPx1Jss71WKlk4wrk=; b=rhNipQEdFyrhaNtY
	IR40TiPgAAIfnwHzWJeRNh5aOqZXdaGLIgDoPxXIIYX9P0MHeW4uN7/nWMDHCnWU02CxP/I5j/Dys
	/fPyCzi027LVkbgDKM1JCue1k2gNEove1Oup5yT8vayiPkp8NfrbFbvy2mM4mPzZ1YeQfwIJTQsca
	rjuxGRY64Ikm2qfT44CWtb3wcSuX3cG/Hs80W2F+EuAnavLUBkGxQjlqdRIqSCEvre9w2XQfE29WL
	dSG3z7bWVfD/lXj1pIrVLoJLVg3D4g10HCqPCLTIcf+YOA1LloIKv1SEw3/2xYk02PZz0V9loEYlG
	zFnRjOef8jnKUewveg==;
Received: from localhost ([127.0.0.1] helo=dalek.home.treblig.org)
	by mx.treblig.org with esmtp (Exim 4.96)
	(envelope-from <linux@treblig.org>)
	id 1s2Yfw-004ILZ-2R;
	Thu, 02 May 2024 15:48:48 +0000
From: linux@treblig.org
To: sudipm.mukherjee@gmail.com
Cc: arnd@arndb.de,
	linux-kernel@vger.kernel.org,
	linux-parport@lists.infradead.org,
	"Dr. David Alan Gilbert" <linux@treblig.org>
Subject: [PATCH 2/3] parport: Remove attach function pointer
Date: Thu,  2 May 2024 16:48:22 +0100
Message-ID: <20240502154823.67235-3-linux@treblig.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240502154823.67235-1-linux@treblig.org>
References: <20240502154823.67235-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Dr. David Alan Gilbert" <linux@treblig.org>

The attach function pointers haven't actually been called since:
  'commit 3275158fa52a ("parport: remove use of devmodel")'
topped adding entries to the drivers list.

If you're converting a driver, look at the 'match_port' function
pointer instead.

(There are lots of comment references to 'attach' all over, but they
probably need some deeper understanding to check the semantics
to see if they can be replaced by match_port).

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
---
 include/linux/parport.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/parport.h b/include/linux/parport.h
index 2a4424b601565..190de3569e25c 100644
--- a/include/linux/parport.h
+++ b/include/linux/parport.h
@@ -252,7 +252,6 @@ struct parport {
 
 struct parport_driver {
 	const char *name;
-	void (*attach) (struct parport *);
 	void (*detach) (struct parport *);
 	void (*match_port)(struct parport *);
 	int (*probe)(struct pardevice *);
-- 
2.44.0


