Return-Path: <linux-kernel+bounces-112607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12081887BE0
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 07:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4ED942823F3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 06:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA4F713ADC;
	Sun, 24 Mar 2024 06:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="YCTSXf0X"
Received: from out203-205-221-236.mail.qq.com (out203-205-221-236.mail.qq.com [203.205.221.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AF7EDF
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 06:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711262303; cv=none; b=SAEuueuaUsxqQOix0tp8Gnid5XF2DDmUqEQfNghK6tfUPh1WmL9y7BFZDCcVrX6XsPf8V5tgNWkJ1aO0wez8uEzZwvWfLnfGAqp9etyboYfhfM5l+onFSjy48I09gQpkIPgsEIortgbu3MpQJkSyadpTRDsqrENEZDE0lqSwmo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711262303; c=relaxed/simple;
	bh=i/A2pfqpKE0WiCT4AfB5UQmx9VB1sSd2ocTqjcw7boI=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=TzADrzLUfloYLWyk2J3qb3byge6kiqtEdmiXqPTJ+1jK9Ae1dNbXB/pZWw+ZZ2F2AhTDn/i7BFkFlJhHZW//xgo3FqHnjSN8BIoh5T+ZfukeaBLXfc74k3pqzNAaxuFVc63No6+O9MSq7JL20xqCf7D8jS9bD7YgssvXwb9gUZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=YCTSXf0X; arc=none smtp.client-ip=203.205.221.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1711261997; bh=i/A2pfqpKE0WiCT4AfB5UQmx9VB1sSd2ocTqjcw7boI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YCTSXf0XL0cXrS+Z2gp/pb/kqX9La5T/znIh9Hq5n2b6ax89+i6QqhtMozMHG8lhA
	 asF8EIFI44/dqjFf7ERCx5t9SHlsiP3bHNoREAn/BRH54oYcDu7lYZ8Y3uqQJhkwGm
	 4zc0fpNm9EM1M67ltFnnQfsTmW9aeGBVpOqtAsYE=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrsza1-0.qq.com (NewEsmtp) with SMTP
	id 850030CE; Sun, 24 Mar 2024 14:33:16 +0800
X-QQ-mid: xmsmtpt1711261996t01awpkpa
Message-ID: <tencent_C8BEBAAEBB1A33CC9E9E1B1E4B461B882508@qq.com>
X-QQ-XMAILINFO: OdIVOfqOaVcrgGSuue8Ej3Hokc+zkAqdDGp6ZNBt95sMaV7GGj59KlnY1jHAsv
	 flsIflDMYigeB2hwztetdQTHEMqbvMXdtAqYuXX9DiJRu2S9ZKFiw7zX3Mb7y8PFUrfeFD+BeGtR
	 pLKKOTpiPD8UhVbuoFvdYPwgMnSOL5E/wk3xkn5sTe+bd/M+I4IbLWMF5gZTAkIfoNWvdP0JT/Xj
	 m/aThp+n8HjIKU0ZV01KoYhdYybywNyIj4trTAIjMZ+rDa1qMPpbDfsvYEmceUuhQEn6RuihDqFj
	 ppu9h82OyNg0zjV+XykMpOgKk+9SZ7cTuQm7okfeJnfr5DMRDlRYS30lU5gv16ezJf+1SOGhAawx
	 xUFLmj2zre0gVpKexaECOSkK/598m1+LvSmsAWQTopsNwWo/WM5lzTjA2NpMBEyyoa6RQC4qGz4g
	 O7qLqCpM3IB+noAqx42hIY2l5aDpe7RSpJvomm9FJ3U8jJCPlHWy6zHiqLEKqoeKp76yGnpO0hS3
	 9M5RQQvDGJdOAJTWjfxWsZrt1A2CFVRxp7zmY1CfgECD/PcZNQYkKgW72Gmf8ELh1M4JFihduvW3
	 TT86FrgLb8yBGPYAhJ/D/MlSeia6Fnbec9LEy+MY7HDaveRi6QILYGC791zeyIUOlgCvmpoB+NE0
	 h52UMgPVKDoymeOM56QLAMsQft/lUhpMDlzHkmrrroAT8GBbnwWZV1CHiMo3KWkV/fqaf4cejiIM
	 Jo1Y9vHtVh7KcxnvIYJ/tELYaekTASFBa+kq9tx20DPZAHlL4pN7ErZm8otP/qlg3W6Je4pwlSw/
	 ppioyUv72l8qXkDMIUO3o/qGAqzpqmB4WX8IgeHFDycHskebF1Dk/c7kHn42t/gA2MCmJec9o9FJ
	 Gmp+DLeovVwVY1uNN+DGU9QzCmJaqpiIOqVkLTbAtYAytGe5sTwhRlfEe1AfQNqA==
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+f59c2feaf7cb5988e877@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [exfat?] INFO: task hung in do_new_mount (2)
Date: Sun, 24 Mar 2024 14:33:16 +0800
X-OQ-MSGID: <20240324063315.514753-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000093ea0d06142c361a@google.com>
References: <00000000000093ea0d06142c361a@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test hung in do_new_mount

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0a2c2baafa31


