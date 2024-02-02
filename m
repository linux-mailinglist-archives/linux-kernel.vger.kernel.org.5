Return-Path: <linux-kernel+bounces-49622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F81846D10
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 10:56:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A7521C22C77
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 09:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1DB277F26;
	Fri,  2 Feb 2024 09:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SSq/d0QY"
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60485FF1C
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 09:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706867802; cv=none; b=MVDe/4GMIDYlEbV+YKq0jPura8mmBSeaK1KemuLuB/fgFlPmp94sv2jlMAmUROkv8gZp6iXEl3ejVtIsLaKDcAYUeKIHjC3KO1MK+901MQvKTezy3sWBvYpCYTUW47VCyuCA3CemFQ080pZF64vOi0GqgP9IrIkwja8xXjasu1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706867802; c=relaxed/simple;
	bh=pAxvCQta47fOU5g7qdy5rF8FdxNqwzWp5W9m32nACwo=;
	h=Date:Message-Id:Mime-Version:Subject:From:To:Cc:Content-Type; b=SKeD4G0XiRJ3KFL9hn/ZOJZz/r2EuMzKplWFMwGNgSG0nt32AWzyC7WMfebwGKtHq2QvMCYIzOrjb2ils92MfigVYXYA8sqErpfAbmK5zy1hSRaCieLCnPxzD5TtVmdudO+DBloahwUm4w08sFH39VQrX+SuLCMVEcBKsSyWYjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SSq/d0QY; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--saravanak.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc3645a6790so3457853276.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 01:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706867800; x=1707472600; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=eh0Kf14ZdsqM6zBmES35e03QqdDRMa5lQp6Xce6fbY0=;
        b=SSq/d0QYGLIC68Xyx/Afw68jGzXxbzy0st3yDTmE/ZknPNQW8A/RKqNAouOg5g/mWj
         oILePRoQnwN0QqxWva6jgJ/snaBoCUKnfMvC+3gJTqUFk2nGQY+EBEvgwH2a2g7qPbOn
         F6d/VVCzYXED+u/bhrfGi5ySgzLOp/j7THZdDmJDrrwU4+57KRngw3t3yee7JzLqhZV7
         e0Tsy6ipOG0t9rKqiOYoi+RIT2iFR2c7KIU6y4W0Cf6+cN4P3OR9Ac+ygdPP1GR3qoxB
         adh3NFmR3fqz9kY562AOZ/CtpuJals0ADtQWl1d3Q1Qc+LB5u4EkKJ+YRmb2QHArztLQ
         6Tzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706867800; x=1707472600;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eh0Kf14ZdsqM6zBmES35e03QqdDRMa5lQp6Xce6fbY0=;
        b=TX0iXJNEYFYd25weGkqgqW95aJzqyCo36Pyqf9q3DIOJBThDnN1tdaoO+0uRM/U3zO
         3xxrHjYhxUKQiUKVUpYwUAR3fzosnkdCTZaNrK0iWYUg10PLviX6coTxSqKqHNaFu65q
         QGBgIzAXan1oWhVX1uFWWlX32rQ0zHZZeOo6s6Xb2u2S6AnlQAj4KIbOEffeG2bA9/Jf
         y3sFPhUjZlJb6E4vy7R+ht0FJpG55VndKyrZtFCri4dWdfoxYQaxdNWEXG6gQPfCDhPj
         O8jf6ymERPCQHnxZyAhoL8a/FfZtsuRmdWbGgwbfBohAsAI0g8vnzTli/u2BOT59v4jp
         RtMw==
X-Gm-Message-State: AOJu0YxCogMFrcu6PAIEy3YzWU2Ozd/bhjP2WgHqrLVEPB3c/h8+PX0M
	KS4OlDS3x20nGLsck+Lar6VSistnl5B9mSBckOUlPsF/2cDAj7AXksgxMhuS96Tk7dcHN7rpbNV
	PMYoF+qO4MlBkaw==
X-Google-Smtp-Source: AGHT+IHi1jGmyT+botcgcw3EkMwc6R0ty2Z8l+XiGQqRryRbUt0xFtPm5ivKpgs8zDHiEJwAr2+kAujtPdmYg1o=
X-Received: from saravanak.san.corp.google.com ([2620:15c:2d:3:6f0:da10:9cb3:5b3])
 (user=saravanak job=sendgmr) by 2002:a05:6902:2387:b0:dc2:1c5d:eed5 with SMTP
 id dp7-20020a056902238700b00dc21c5deed5mr1943851ybb.12.1706867799812; Fri, 02
 Feb 2024 01:56:39 -0800 (PST)
Date: Fri,  2 Feb 2024 01:56:32 -0800
Message-Id: <20240202095636.868578-1-saravanak@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Subject: [PATCH v2 0/3] fw_devlink overlapping cycles fix
From: Saravana Kannan <saravanak@google.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Saravana Kannan <saravanak@google.com>
Cc: Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is mainly a bug fix with a additional logging improvement. Lots of
details in Patch 2/3.

Greg,

Can you please pull these into 6.8-rcX after Xu gives the Tested-by?

Xu,

Can you please test this whole series and give your Tested-by if it
fixes your issue? Also, from now on, to debug cycles you just need to
search for debug level logs with "cycle:" in the message and convert
them all to info level logs.

v1 -> v2:
Patch 3: Tweaked the log messages and the commit text.

Saravana Kannan (3):
  driver core: Fix device_link_flag_is_sync_state_only()
  driver core: fw_devlink: Improve detection of overlapping cycles
  driver core: fw_devlink: Improve logs for cycle detection

 drivers/base/core.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

-- 
2.43.0.594.gd9cf4e227d-goog


