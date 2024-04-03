Return-Path: <linux-kernel+bounces-128994-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 578758962D5
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:11:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 866FB1C22C03
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 03:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6841B224C6;
	Wed,  3 Apr 2024 03:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="gn+CaIq7"
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419721BC59
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 03:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712113910; cv=none; b=tpbMH0m+P699Qth9jMIK2RkUYolEsyG2+38wd+1kgHq2ZYDFsuEaztAa5NeIAH55Ivnlj9RSgCQedmVBbWdTUHLnpldrG6/t3URoL0drxPAMTWQSXLXODxqZ/2uyH3QTjYW5LsF+DCHS1toZtayi/+lINxYnhQXMFBxFC3l7res=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712113910; c=relaxed/simple;
	bh=JrM1uuFnTIVBKbjDsmBuCX7sxswHD1aKYDxO96MS6V0=;
	h=Date:Message-ID:From:To:Cc:Subject; b=V92BLM1VNMlKz5UvQG92GWgLvI3WdyINQ2Noge7UMT0FCPtv3tkS1SXBloX2sEswuHHG+oSp3R825vRaV6sVgnXDp9AP72kQfAE++eImhXgEX+pNhYNrf0+Id6tuNBIECkVSrrnOPaeDy+E+2HFHDF5C9kLy5lxOuQ+iR8OKTnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=gn+CaIq7; arc=none smtp.client-ip=209.85.160.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-432ff72d745so4455291cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 20:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1712113907; x=1712718707; darn=vger.kernel.org;
        h=subject:cc:to:from:message-id:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=10kPDwtnOEt8AZOr3ERW9xy/nQdgWpYkiYiozTsU2nU=;
        b=gn+CaIq7e0C/FTM3wnme0xjlmWmFpeRSGdYQE9wd5msEJ1e67odLHVokusixkHkG1Z
         SowUMEQfzMJbQD8prpk9GtuzLbE0qKdLX0ptS/emTFqZQJTxwIG8Fr4FabJbocUJmYyL
         Y3ODP7gr2atYEmXCgIicf1tSxSh/IEqI/FCXfFKkueK1bRgj0qynD0SNGa2wNXjfP+y2
         Vtd8ABtS6ujLw8E6cTpnIXFY9vOjw/Z7AMJk8GEKpRecTvJX831XfE9BIMGDxgbjirWD
         r6L+diK6v4E4cazySK3Hy45i2JuIHMfJLBxSls9RjhPD9KHwOpumWQf8TdYGg2BxTRfZ
         cc9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712113907; x=1712718707;
        h=subject:cc:to:from:message-id:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=10kPDwtnOEt8AZOr3ERW9xy/nQdgWpYkiYiozTsU2nU=;
        b=V8gYIaV6cRLwqJINVZ/FflgHhdGXdP2jVTb4sSEugZs5TDudrOLeyQ7vK13Cefpsj2
         nhvhh2pR+ZWMP5nzvJPx0cvVJGIZacv9RWOjCMD2/h+MireL7ElcNViL4itoZqamPyQd
         3zSHS7RCos2p3wtkrvPRIyQ1bCWeJqwzFEoCRJwk9V1DZN9lgIqI8xoc/a1i7n+Qdcai
         QVdlWclbhFAJAo+SJaEqCE6xrhgFts+XQa0N/cyH5ecoNKfLqKvnthL0l1qsvqUU1xLz
         yebz5YBhDzY5ts1KWvxN1WYccvsY6LBiFfHaM2WfOHImOokfxyrdHwR9S/CEgmtblSlW
         RSbA==
X-Forwarded-Encrypted: i=1; AJvYcCXYwMqUB609oRd3Qa48MX2KoGjMmNn4CAPe173szG/1TGyesPNaCuE75Dd5Z/URUdo7XbjAOtiWcB1MdgxzQ77FgUS6RURa+IdMqpxy
X-Gm-Message-State: AOJu0YybWz+FSS/FG+mAPhCPH7lqRBcvYPIoic98Zdw3uotENn4HUkPa
	oFJ4MMMmOG6pb4NdUXOxlrOI0q0UlxgcguamzzHqhAiL5fFaTN3pBliB3KhVcw==
X-Google-Smtp-Source: AGHT+IE78oAKuIVYbax+koIpgJJOpn/ZYMkQ/QoOzelQ16IOpVq6C4shR8C6h7JU+WX+5bbERMuWHg==
X-Received: by 2002:a05:622a:1711:b0:432:f37e:d274 with SMTP id h17-20020a05622a171100b00432f37ed274mr2421865qtk.8.1712113907185;
        Tue, 02 Apr 2024 20:11:47 -0700 (PDT)
Received: from localhost ([70.22.175.108])
        by smtp.gmail.com with ESMTPSA id bb12-20020a05622a1b0c00b00432ff561b2esm1776656qtb.79.2024.04.02.20.11.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 20:11:46 -0700 (PDT)
Date: Tue, 02 Apr 2024 23:11:46 -0400
Message-ID: <cf11f516883d7fbf75a34f7981174e73@paul-moore.com>
From: Paul Moore <paul@paul-moore.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: selinux@vger.kernel.org, linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] selinux/selinux-pr-20240402
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

Hi Linus,

A single patch for SELinux to fix a problem where we could potentially
dereference an error pointer if we failed to successfully mount
selinuxfs.  Please merge for the next v6.9-rcX tag.

Thanks,
-Paul

--
The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/pcmoore/selinux.git
    tags/selinux-pr-20240402

for you to fetch changes up to 37801a36b4d68892ce807264f784d818f8d0d39b:

  selinux: avoid dereference of garbage after mount failure
    (2024-04-01 23:32:35 -0400)

----------------------------------------------------------------
selinux/stable-6.9 PR 20240402

----------------------------------------------------------------
Christian Göttsche (1):
      selinux: avoid dereference of garbage after mount failure

 security/selinux/selinuxfs.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

--
paul-moore.com

