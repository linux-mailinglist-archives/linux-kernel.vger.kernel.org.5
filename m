Return-Path: <linux-kernel+bounces-92651-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA7E87239C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 17:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5CE62875F3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8358E12880F;
	Tue,  5 Mar 2024 16:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="fsDjqMKw"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DCC12837B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 16:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654686; cv=none; b=oQx65NDgAGDz0AIM3vOvuuOCaLaPNbf7IbFHfYFBprl5HqIvuqnBGAXvK4Q/oKc+9K1cGEs8nR7T22NtXlNXvRAk3cezhjv4VRXLEQWKmE7iuu7Zz4kDbhb6dwVyN9wB7kCINaMVdzGMnUSVrktI0txNf2457gTwOz8mW2Q3BvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654686; c=relaxed/simple;
	bh=q0H2NcD59dhHTfKo451ZTlcHqhnaVKga21S64KdL2as=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hyBaqUUFLzN6ucuso5/kSsSB7q7OhwDrG+Xv5t8Bbzu9Kk156AX9JnBzpOKRNllVHvDRi6N71pSpNsEFCOn0a7TnnqiIxT88wJRHUCXXZjMIMLq4NmCPcVAQ41u0eYVF0aaYlvG2EDrgRxrhuJ0IMSj+B0AXyNK+VnlbuTDSZmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu; spf=pass smtp.mailfrom=szeredi.hu; dkim=pass (1024-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b=fsDjqMKw; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=szeredi.hu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=szeredi.hu
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-55a5e7fa471so8190409a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 08:04:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1709654683; x=1710259483; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q0H2NcD59dhHTfKo451ZTlcHqhnaVKga21S64KdL2as=;
        b=fsDjqMKwWJOFnPCn0DCnKFaEXpI7vkz3ut9smwncEpR/tO3vbOQimuSlebJM2I54O0
         q89FiTfVOvqty18mCYkPThQef1eW/YFx+oxoNQAjRGr5pKfOna+UXWNtf78ZNxkgNwWo
         +K8JsnhaI3QiDSN932uo3EDNNJDp9nOlQIPtc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654683; x=1710259483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q0H2NcD59dhHTfKo451ZTlcHqhnaVKga21S64KdL2as=;
        b=TKbX+5B2nzBerdQglGlqA02U1DqJTwVzjiitUrletYwyb9HOfyixpoIyd8pgajbltW
         GvG+TadrGnILAq1tG3JTMcTfaGTg+w/3yZqxS/F5ceODeNl30Sx5w6ACnAOL6QDz7kgA
         QFXSWtEIavXxAeyvyWqTDgq1Ak/OZ6jbY1nIIQCctru8K2Rp2rCX7bx0FDlAmpam91Js
         MuVt0URIsY7EFkEc1Fpion7AIBrdhRYZyFSHau+e6+GYHVO1bV+WoiN+HchavwPvylL+
         lxIcxO9olzjZgWHJstfwrPwdrF+HPCj/CZuKi9v4JHCHUt7HOTGzBv2TW1utET/FKcEn
         ogKA==
X-Forwarded-Encrypted: i=1; AJvYcCXkBksxyFO8TX/MpT68T1ulPUYPaQ1Ka9c7haje6lRTc7H9a8dSNG1xnxw48G2tf2RXfIEpgASr4/wj3DSKZ8DOLmqhXamOPEfY+cSV
X-Gm-Message-State: AOJu0Ywvkr9/z8lnW4eS5tnYmut6TovLyfvoawFdP23iOOPM71jf9Bsu
	PFBGi4Mp3VS8tSUn9zlDZpTCj13kg2cGwHZ/zQJUt+ZNzfb6/3VEqIUApTg56TY+xdoDV5Wwyn6
	mc3H6aaCrjv66r5efaHioNASP1D2iWoX2NCn23w==
X-Google-Smtp-Source: AGHT+IFMZIwMXMwn9b1NuGmsElo9IYaOZRWc5K/okKG3s2qc3CABtigMHxo2c25ZIM++4Um6Tc+NwcUVMUZHUl0pEDU=
X-Received: by 2002:a17:906:ff53:b0:a43:f9ff:2571 with SMTP id
 zo19-20020a170906ff5300b00a43f9ff2571mr8629999ejb.45.1709654683091; Tue, 05
 Mar 2024 08:04:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231028065912.6084-1-zhoujifeng@kylinos.com.cn> <20231107081350.14472-1-zhoujifeng@kylinos.com.cn>
In-Reply-To: <20231107081350.14472-1-zhoujifeng@kylinos.com.cn>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 5 Mar 2024 17:04:30 +0100
Message-ID: <CAJfpegtK_52EO51FANkp4=3-BcrLo0eP94=7es5AvjS4R1vvjA@mail.gmail.com>
Subject: Re: [PATCH v2] fuse: Track process write operations in both direct
 and writethrough modes
To: Zhou Jifeng <zhoujifeng@kylinos.com.cn>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 7 Nov 2023 at 09:14, Zhou Jifeng <zhoujifeng@kylinos.com.cn> wrote:
>
> Due to the fact that fuse does not count the write IO of processes in the
> direct and writethrough write modes, user processes cannot track
> write_bytes through the =E2=80=9C/proc/[pid]/io=E2=80=9D path. For exampl=
e, the system
> tool iotop cannot count the write operations of the corresponding process=
.
>
> Signed-off-by: Zhou Jifeng <zhoujifeng@kylinos.com.cn>

Applied, thanks.

Miklos

