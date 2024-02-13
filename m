Return-Path: <linux-kernel+bounces-63841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FAB85355B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:56:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17DB91C22DC4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C467A5EE76;
	Tue, 13 Feb 2024 15:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="t/lQtua2"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FDE25F47E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707839762; cv=none; b=fkk6BmRnDH23qmVtbsS8yV96ptRb0MBUsJqOcLIuef4zP/mbkETm/Hb0VKP7TAtZnDH2zPOTTE+fPR6WmLu7FOoonYH2U1S9MrqVqAYUvW4BSlD7JhJyCsCVmBSeY8fo4zvpXZAmwLooaM9oLBngJ0IB95d22VnwPPMCwLnwFz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707839762; c=relaxed/simple;
	bh=hWMAioBnPaY3o/tfzz5sN+jFgjLyXD1M9Gr59P8svxU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SCKiBBnmxUJz+chWdBN3aha8sYabuExQwK8HeLyiV9PE5Y87RzlhY/FxTNdXIE8bTfuDMUKE7Shlksq3VqKNM+6VZAyGmdluOQEl7YRl7AAFIYear6EXvqbQx8efRPFZ/9b59hlCiw8OAW+Fh18qsO1i6QZ2ptqW0Q1MW5FFuWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=t/lQtua2; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-363e7d542f4so3905475ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:55:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1707839758; x=1708444558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wDE12yUESOyzwOOqs6qP5OzjvYX0WWrL2dOPvbiyCJg=;
        b=t/lQtua2NxoMawJOceOuybgPH7gUYRGIxIdgdLrigdokK9uyLiaUJk1CfAcekNbhpi
         E6ZNjPyGYj6j6kZuVYh53Lx4YNhB15i6cy5U35tbBXPYliWcRcMaGfjQyV2PrHQsK9uQ
         yg6L3B2iMFc1eCrbo5YnZugpXI088njx2fM/s++TI7ylIGLcsRoGW9XfDF9ck/n4JLRE
         DXRFCgx3eLLQtbn2sAiQ6YhJ3Z6/MaTyn6Uq8IqkVzQLaxkY4cOHg24jmRoqllvl+WZW
         3Bi9HYqTZP1ANp2PqzCa3CO+MjG9C57GLdjwXBAIsl+EPuOYZrZf62oLFVcsTPir9Uui
         vI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707839758; x=1708444558;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wDE12yUESOyzwOOqs6qP5OzjvYX0WWrL2dOPvbiyCJg=;
        b=XipF7xlHs9NrH7DLXu7UWWhQRc+gS2J3bDkl+lJ44o9hArAb0jmTNKj7gGWUGJT1M2
         64B42LLdFs8uKysDTOnFYNj4+mQiQIpR0jfiMBrkwJC7VoR+mTlaL1+GYVuj2jdu9qR8
         uDWARlVxSkwrpqa/h/iuFS7J3jHdloa3xwkJxaLZ31pAH5Ds2puCrmY0YorGdvaQapnO
         6cvk80KMVc0PTFTZXvK587K3ecurWv6WoUQCQzoKF7pId/DNXhLUMWx+g/0AswXPH87M
         noGl+5pi4xz5CyWqeEMIXFnR5bACvVZAII43X100lPYSzCInUH4qfwbxfXPGka2ZZq8Q
         zmAw==
X-Forwarded-Encrypted: i=1; AJvYcCXX5lssH7MxMJkHsUWtMG5uXelX5UQnzUjOT93FbnM1bIfNTjp5+FmYz/4Tjd07H9GUg/5dSp12ceW9OjCNUUWvDJxLqymevGWIXwg6
X-Gm-Message-State: AOJu0YzxFEKYSKkKgBoY1NOD00OsTWdsp8k8BOxvv5GuhIhG5ULL5d6Q
	jSG/mTcUunC1BJUJqvkTWKA0MOCI1zVN2uAycAkSOqjoWgI0z+Rm5KrFphnhPFbtzyPLkYZFpHl
	n
X-Google-Smtp-Source: AGHT+IEODykzgn8ir9YrP0mljLSv9E/0vpdgq46Aapczeh99yEQl4PF2hUUpFW8gJ95jH6d6/2UxpA==
X-Received: by 2002:a5e:8909:0:b0:7c4:527d:628e with SMTP id k9-20020a5e8909000000b007c4527d628emr117369ioj.0.1707839758138;
        Tue, 13 Feb 2024 07:55:58 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXtmRN9hf1sTEqQHaomPdDhjZ/rBqevRFQLhRGOvNdVgrrmzMRU46ycGbZdKsVahi7rr3CCulnDlGn0BJCFpzzPWfrqmKcmyOIkohgol58ihRNuG8+McYohme6FmujP543wMnm/GLGvwbCXwyCapal26uTc7epXwG1faZx0XcQZd8e1dfRE/5n0JvjBOAy5vAKs3jiB4mqcZe+FKEoKeP+rQrS2t9y+WodxgE6li2LrIf4tTpUkIO0EBLoieRoDdzN7/nMoZ7PsROrLA2TeuGaUolKkrKX5cHVgWbwC5nQskTG9O8ZBhiJ9zt+foE+YBG4uoGJJNsHK7MMtHfEy9UHEsspFcndMI4XuRq5U3zEugg1HnnhUmUy3Pu1Ld9PGKQsASQk5EkRLEj777Jy5SuicR4XeRRwYKEMWtSBKVQMvCCV03TLdwihjU9FCCc3+HSKHcNUrxFrum66C7KOcpyf4
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ay31-20020a056638411f00b00473ca57bfefsm403153jab.124.2024.02.13.07.55.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 07:55:57 -0800 (PST)
From: Jens Axboe <axboe@kernel.dk>
To: Denis Efremov <efremov@linux.com>, Arnd Bergmann <arnd@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <ndesaulniers@google.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Christian Brauner <brauner@kernel.org>, Hannes Reinecke <hare@suse.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, 
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, 
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev
In-Reply-To: <20240213095918.455478-1-arnd@kernel.org>
References: <20240213095918.455478-1-arnd@kernel.org>
Subject: Re: [PATCH] floppy: fix function pointer cast warnings
Message-Id: <170783975707.2331975.5627126509877821543.b4-ty@kernel.dk>
Date: Tue, 13 Feb 2024 08:55:57 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.5-dev-2aabd


On Tue, 13 Feb 2024 10:59:07 +0100, Arnd Bergmann wrote:
> clang-16 complains about a control flow integrity (kcfi) violation
> casting between incompatible pointers:
> 
> drivers/block/floppy.c:2001:11: error: cast from 'void (*)(void)' to 'done_f' (aka 'void (*)(int)') converts to incompatible function type [-Werror,-Wcast-function-type-strict]
>  2001 |         .done           = (done_f)empty
>       |                           ^~~~~~~~~~~~~
> 
> [...]

Applied, thanks!

[1/1] floppy: fix function pointer cast warnings
      commit: 7789bf05529889a39bcf4cd17a68521de063b88b

Best regards,
-- 
Jens Axboe




