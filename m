Return-Path: <linux-kernel+bounces-143846-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EE978A3E27
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AD13281F63
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26F3553816;
	Sat, 13 Apr 2024 18:56:16 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C2F23BE
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 18:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713034575; cv=none; b=riazcSFHyOADZi1GpKkC2lSOVbzUrsFFmDb/Gls3ryzMUAyC6CLGPYP2O4SxEX4IObmmJPpA97Rq137aK/0L+Z9JFowst1vgb6Qc4SPGiyQdHUUTU72oI1b+p8lltfHQpgAhIUBAbmLIrO2bpJ1LPhAvn3jgYOgwYXELD2n1l+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713034575; c=relaxed/simple;
	bh=P3wxi+jnW/OMq+gyMOP4JPyF+nn7EQfP6xvqZD0l7c4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TilD3YyxfTiaaOlo4ockeUrsA7WzL6Yas0sGW3WLhgfiJDa5+xQjxWlpz2nEWT91CMMtEvRlSkyI7etiEFGhMom4MHGTW7roz62k3WU79/5lOyRudsPe+TgJsbNsiFpypakHK/noH0L2QNfegbsavVmmgkCMXRlXGDYJ0kiRQ9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cf265b30e2so221003339f.1
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 11:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713034573; x=1713639373;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P3wxi+jnW/OMq+gyMOP4JPyF+nn7EQfP6xvqZD0l7c4=;
        b=HbcXUNu3Z6IHNRPRAGRsVoSgN1ZkAzU2XBNouea8bP0vGQ5erBR/CuqjNU2KS6F3yT
         maf2mLBxHgb4yV7AjmouaMXsHlvcgglakR2cYihCgv3W+bR+MSnyPdYF8U4Y5FgkUZFG
         z9ONzv6Al8iTTI4cz5JYpud5/fznk6WrkKp4lBilgznkRPOTyE7BD8wRLwtASPhoGFGT
         NP5T0Q1sXALalV33hqg8IhXAyGt35zPEN7NO4J1ZnHVvkqB6RKKv8hFpwWConyzt+vjJ
         T4l1yGtRYmKaKO6e2AjYWs3jQQQ3LYLrBg/SH2AZooQj6g/zNcU+ayGCnniPryllLOsw
         cfrQ==
X-Gm-Message-State: AOJu0YxedDy4i7lvBckkArvgsM+OL2+9o3nCfH+os9gZ7FRPQzKP7Vfm
	cdHLPQlRYVO4GFiZZKIKcH/+vva/cgMac0cjBoeb7hu0HPF6OVJLp0Tmsd9pX8D1UwwAip3u7kI
	ZfRHlglC7Wu5KDnd8h/u3/LwYoVuyOVKCyUzpS0kGTQ3hk2XKwvW8qZk=
X-Google-Smtp-Source: AGHT+IGIhQqMCQHJ+yy8bd7Rac7FAUdsvkmpEVM7WsWgzWxnRF8Ov/9fiPRw+y0oumT40jAJc/7Edh0X0s3hlwNwVq0Q/I2e0pPs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6d02:b0:482:cd99:9d86 with SMTP id
 he2-20020a0566386d0200b00482cd999d86mr360213jab.4.1713034573610; Sat, 13 Apr
 2024 11:56:13 -0700 (PDT)
Date: Sat, 13 Apr 2024 11:56:13 -0700
In-Reply-To: <0000000000005ad04005ee48897f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003f90390615fef1a2@google.com>
Subject: Re: [syzbot] mm: page_alloc: Fix uninitialised variable in hfs_revalidate_dentry
From: syzbot <syzbot+3ae6be33a50b5aae4dab@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: mm: page_alloc: Fix uninitialised variable in hfs_revalidate_dentry
Author: shresthprasad7@gmail.com

#syz test

