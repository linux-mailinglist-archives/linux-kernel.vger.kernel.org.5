Return-Path: <linux-kernel+bounces-71748-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B824A85A9D5
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 18:24:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E738B1C20DDE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 17:24:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D3944C93;
	Mon, 19 Feb 2024 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mvbzA6Ku"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842DB2CCA4
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708363472; cv=none; b=n6ARcfcNyR6VbJ0zzfhyPbY3enxg0syMmz+vhnbyMCSW1DqbuUBY+G/qd1hHwBDtXlSQKljevkLAUFbxwHL4IPlb1EPEGIOpH0Eq0NX6csWJY2Gn8lJp4uTZ/HGK40pA4zPFugBjoHYEOFOYeWOH/EEg47Z8t34AeDvGhA/YvIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708363472; c=relaxed/simple;
	bh=IqXAlLKeekccseiZoETdUwjQ0rAhOYE1/rlcGiLxS4M=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=b0ytYTCAceRlJpG65wjCo3WQEnwtKHyCXQiCWk+Y4FqJtY5tmtn6E6cmpNPvMFoTb1KpS+EWGj3aFiRXxxGq7oPOh1ccOtM7bAXWxU42XlCbkb3ltGkFMC8v42uVsoBg1cIVAHRM6Y3DMbF/ErmK70lKDS6IRhwTGoFzH3BOFoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--dextero.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mvbzA6Ku; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--dextero.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc64e0fc7c8so6304574276.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:24:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708363470; x=1708968270; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=IqXAlLKeekccseiZoETdUwjQ0rAhOYE1/rlcGiLxS4M=;
        b=mvbzA6Kur06QrdLMT5WXpwjnC96UPbA/TeiKvuIR1cczySqp7pXN9urcb7mVITNc0D
         wS00Um1PCNrXZdAMm6DsPwlbIn5Zlkf7kHD4YNfU5EwKlvxp6X8tnvZ0FrtAUcYaG8mq
         ci2HfzX34JLnpdC1hfEVrhsH5lMFNAP6G6j1jFXyCHIUSbDoZ4vzjeLG1L94NQd8YBJq
         1zUNDaoGvINU3tZ6YtweUhqYZeT2c3T4AynQvExWJy0Q89trTwzeTanir/oXKLfrHAcI
         oqqPlkZZlBH5lvsgJKjEPyeaj200NfdSWQ66AlOqbirGcb3S+nGpTgK3mdFCjOuCJ0K8
         da4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708363470; x=1708968270;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IqXAlLKeekccseiZoETdUwjQ0rAhOYE1/rlcGiLxS4M=;
        b=ksJMv/YD5P4e8Mw15/TkD7XbCiM0nC9D7WJ+93EXTugRfil2lx4eDqk7yJF/sUdFZO
         ioCt2T7fd5KN/7jipn3ORbEACvDavexfnbKRnh4jqpwWLhGObmLvWKlFGrOTgi8ku4jV
         BHiZgRL7RM95YFnMNjHXU+iWmhLprPDVCHQS6On3QVx5uqL9wrWC6z3LGDdTOSJ9vKdT
         oyd2ROBshVCi291MsnrVKYsnDLe1DWTh8QAvhRpOGpGm5axj/dDCymkCMGkhYVmyJc6g
         fGCsQ8PQj4abPkbr/V/mCGzh+Pt6rpXdKCCQixI5MTIe0R0sVy4FQR7y6gENp2krK6Tl
         mBig==
X-Forwarded-Encrypted: i=1; AJvYcCVBlquO4zbg9xNwoHoRIr7pl1pzxhlJ/+uYKFshr5DUsUjUOyMmfz9JaRNAG5vVyAHhz23WkKFjymOaq9FXeVOSD+C0N6ffq9WTCPSw
X-Gm-Message-State: AOJu0YzGBKa21acKD18eQAUXLG57oQV87BFaP1hYQw2HzP5FxgjoU5J0
	B8+XYmZ48S9jRlbNErtFnLgfH5TJa65aXYcnMn/3TvgbyFqf3hcrLddztyg1JzsZusVVig09QoC
	bThVWpQ==
X-Google-Smtp-Source: AGHT+IHb/LI2umaPKzrGXSM6YYmMbRda0hH22YF1Jjo5mhqYj23QHtTxbCVUfsVZSjB+mHPk+SsGS1fXXoBd
X-Received: from dextero.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:364e])
 (user=dextero job=sendgmr) by 2002:a05:6902:1001:b0:dcc:79ab:e522 with SMTP
 id w1-20020a056902100100b00dcc79abe522mr524910ybt.11.1708363470612; Mon, 19
 Feb 2024 09:24:30 -0800 (PST)
Date: Mon, 19 Feb 2024 17:24:17 +0000
In-Reply-To: <20240115133654.576068-2-aiswarya.cyriac@opensynergy.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240115133654.576068-2-aiswarya.cyriac@opensynergy.com>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240219172417.1383044-1-dextero@google.com>
Subject: Re: [v2 PATCH 0/1] ALSA: virtio: add support for audio controls
From: Marcin Radomski <dextero@google.com>
To: aiswarya.cyriac@opensynergy.com
Cc: vill@google.com, alsa-devel@alsa-project.org, 
	anton.yakovlev@opensynergy.com, jasowang@redhat.com, 
	linux-kernel@vger.kernel.org, mst@redhat.com, perex@perex.cz, tiwai@suse.com, 
	virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, 
	Marcin Radomski <dextero@google.com>
Content-Type: text/plain; charset="UTF-8"

Thanks Anton for the reupload.

I tested this series with a 6.1 kernel guest on a proprietary hypervisor. The
controls exposed by the host (BOOLEAN/INTEGER ones, as that was all I could
get) worked as expected when adjusted via ALSA APIs.

Reviewed-by: Marcin Radomski <dextero@google.com>
Tested-By: Marcin Radomski <dextero@google.com>

