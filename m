Return-Path: <linux-kernel+bounces-76098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 765C585F2E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17CCFB23569
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 08:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E573F1B5B1;
	Thu, 22 Feb 2024 08:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="BKY0nMrB"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 983B018654
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590469; cv=none; b=mAybMsL/yjZUyKFfzdlhGSlSzMpAsbAKWIhtGU2fCZm5/b3Ny8T3rHNRJbUeXyeNTPL4ZM1kpq1qKeG/Og0mIG/9JqqrQAKqG6azrMAA963tZKwD6EhIfwet+tQOFfJKYciO8V60XWDNlYo60uVxaDlbwQvUlNMY4RsXTC4ELlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590469; c=relaxed/simple;
	bh=42vLzQafvh0kEIFCeD5IElVY0TCzlGFSo3aibC2pLlI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hHlkOru38TPSWMlc3lPtJYVa2ZanweFEWq78i47MQYcgRyw1OwZbOfLdBGDS4lXQYu88cBgdKboXutf2mldHVA6FH8Qhldl3no1KwG1GS5ul2EJzggLIc9JsbE5P4+5U3F8v0uqWgTaK8hvEQbbeN1d6fciJVDeC6AK/6pyvpqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=BKY0nMrB; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-565223fd7d9so6711a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 00:27:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708590466; x=1709195266; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=42vLzQafvh0kEIFCeD5IElVY0TCzlGFSo3aibC2pLlI=;
        b=BKY0nMrB4sGhgG78QvHYlyf5iNFHcRbWTzkYKDB7n+RmI9gYYgcsHSkH9BpQjeieXa
         /rESupUjD1Uk84ppypU0FO53lrSmBD+eO3KkOgDvkUQOhBHHWCPn1RqrUc0omm5NYGtJ
         KoJ2L7Nx7MVYlTlqaRzBYoO/rnHVsR63bWmXQ+3Lvh3wK22OiT11NEblS/WVoQ7o30Eu
         aStw7LWuc/8zUh6ciWDt0scw5jJwh8Gc8mVS3GSVyEF52CDGLyKFIqQb57TwWa2F3+Ha
         BADqifFo6EulQVLI6Ra43tx3nA0sAeTQph5u+a5zL9G9OksESGHoO5kzyzwN/j9GlEfb
         5xlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708590466; x=1709195266;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=42vLzQafvh0kEIFCeD5IElVY0TCzlGFSo3aibC2pLlI=;
        b=MCXhcfJiampiOnKZO9CIRwqFgA2hTP3jfMo7Oj2Jti7OUE3IQJfkxL77XH33s6Uy84
         t8DTxObEz+CVauCs4Jd30sD3JdpN7Xl/tNQ4PVgRnvc1lxoMFr+OY8Hnbq5kdocLZ5Di
         f89g+nmih+08N3ogrTbG2DLvTEMMgcr3uxoCwIT0l+PlQ1JWhx3T/GGkJBSAJBEnFoei
         y4qi0xCyj+vIAPOgmoK6Dj3zLr2zEWT7/K9N+aTLpFv1aebyHJ+O+Yll4+KFry+b+E0v
         JoGFAZokadpmYWYumN7HQgVUlDPo0ZYIc6vdB0tnKv2cZSD5I2hUsTUuFeYzaL1ycnEj
         +/ig==
X-Forwarded-Encrypted: i=1; AJvYcCUh3HVbZhRjkFwwLQAyBkqXcLW9FyF47jAeAgscOYSrpqxW80YnindwYZGjGs+gn2YhZA6bMB07Smn2pRQfjHXZLwkLaLvDq7zcA8WO
X-Gm-Message-State: AOJu0YxapdJbOuLmX/O8PumOt1JpU/D66ulenRdAKJrHLFRLCTDEPtN0
	dEgZGYP7l/23jXJXPS2vkXRyvTyaXxQMabM2xDEZgWV1DO6JWvLDqT0z1xJpIR1CSrgnygdTTtR
	kVWwX3zKRIpDuq3YkNNcAjJeSMXlNxXc04pWv
X-Google-Smtp-Source: AGHT+IF9Pslsp2Wk+JCCeyDyiuzYmQpUnrU/YDwfVaY7TIOceUDD/8XPiAnUfH8BKWm+574Wzkl/1hnxv4RUVkMsyGk=
X-Received: by 2002:a50:9feb:0:b0:562:a438:47ff with SMTP id
 c98-20020a509feb000000b00562a43847ffmr375785edf.6.1708590465698; Thu, 22 Feb
 2024 00:27:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220090805.2886914-1-rohitner@google.com> <1920a2f6-e398-47af-a5d7-9dad9c70e03d@acm.org>
 <c7635c10-1724-4db5-9568-d554e1c64f72@quicinc.com>
In-Reply-To: <c7635c10-1724-4db5-9568-d554e1c64f72@quicinc.com>
From: Rohit Ner <rohitner@google.com>
Date: Thu, 22 Feb 2024 13:57:33 +0530
Message-ID: <CAGt9f=T5352bo=K2OAa7QRMds=tQC1JspN+zQ2aYxNRDWGSVnA@mail.gmail.com>
Subject: Re: [PATCH] scsi: ufs: core: Fix setup_xfer_req invocation
To: Can Guo <quic_cang@quicinc.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Bean Huo <beanhuo@micron.com>, 
	Stanley Chu <stanley.chu@mediatek.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Jaegeuk Kim <jaegeuk@kernel.org>, 
	Avri Altman <avri.altman@wdc.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On 2/21/24 01:13, Can Guo wrote:
> I am going to push some BUG fixes for Qualcomm UFSHCI MCQ engine, one of
> which would count on a vops in ufshcd_send_command(). My original plan
> was to add a new vops.mcq_setup_xfer_req() to differentiate from the
> existing one used in legacy mode. But if Rohit moves the existing
> .setup_xfer_req() up, I can use it instead of introducing the new one.

Hi Can,

Can we stick to the current approach of moving the .setup_xfer_req()
up, keeping in mind the following pros?
1. Avoid redundant callbacks for setting up transfers
2. Trim the duration for which hba->outstanding_lock is acquired unnecessarily

Thanks,
Rohit.

