Return-Path: <linux-kernel+bounces-98660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DB2877D83
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 11:00:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C9C01F21E28
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 10:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E9122338;
	Mon, 11 Mar 2024 10:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="s0472jhw"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DB8315AF6;
	Mon, 11 Mar 2024 10:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710151233; cv=none; b=s04u3+HvQUhuzJPhhoSn/8R5IBh92fhd2gEoGN+AvULjLow64ehjLIDvh1eBqSJbgjEPyJFgK/Y3AXArNRiKK48APsUhJf8gsEEPF41Fb3zmbT/Tl5X00QTLztITxP2eRZk3kQmrWGGxO3bhclN8d9ZZZ883CatNt2lUkblFWZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710151233; c=relaxed/simple;
	bh=pDCfqAxwGPGKsmOS5gqNwrfB8JNvL9liHrD/+CR5be8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SSobe+UC+NITc80c3n7s3sksqwfltBR1/NFMZqMlazI5xAaldaDqmybDnVng/oZ9I9yoaVZxGtNtHWNLR66zx4bVk07lEr0kD4Mny6+BouY87Z3Dia181J/vmXHc/OZV5cWQvLxqEN8rs0QhkNUc7JmQm0TZano66dj74fNWY0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=s0472jhw; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1710151230;
	bh=pDCfqAxwGPGKsmOS5gqNwrfB8JNvL9liHrD/+CR5be8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=s0472jhwKH869ZqcPnqFEEwj97zm4jtSWr0URIEWkq0xmwZhxEJkcNiCAD2Tg2+Ab
	 GV2jb6JNfVuX02IP9azzMX4owTYtSD1QdkgFF1gow0tWfvlzECnmicZZwdD+NwyhmE
	 UqjTUnt4bKsn16HW9YCXsb4rxk+kyS67/gL6UBgJly5HGUkOITenWZg+gajgaCMNeX
	 tfr5EhYyE0G8iS5ZSM8x93G0qAFVo9zDqcDCNfIegzcGE7tPgbGzgU2MOuABUU2pWl
	 NgfhfVtrqNLp7rvJJCFreHyY8Q+j8dOPyhkmNy5LYOgEf/5TKonKtyKvhJfmKsRTXv
	 M9eyeq5zM78dQ==
Received: from localhost (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 4A91637811D4;
	Mon, 11 Mar 2024 10:00:29 +0000 (UTC)
Date: Mon, 11 Mar 2024 11:00:27 +0100
From: Boris Brezillon <boris.brezillon@collabora.com>
To: =?UTF-8?B?QWRyacOhbg==?= Larumbe <adrian.larumbe@collabora.com>
Cc: robh@kernel.org, steven.price@arm.com, airlied@gmail.com,
 daniel@ffwll.ch, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, corbet@lwn.net, kernel@collabora.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 1/1] drm/panfrost: Replace fdinfo's profiling debugfs
 knob with sysfs
Message-ID: <20240311110027.34b8b616@collabora.com>
In-Reply-To: <20240306015819.822128-2-adrian.larumbe@collabora.com>
References: <20240306015819.822128-1-adrian.larumbe@collabora.com>
	<20240306015819.822128-2-adrian.larumbe@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed,  6 Mar 2024 01:56:36 +0000
Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com> wrote:

> =20
> +static ssize_t profiling_show(struct device *dev,
> +			      struct device_attribute *attr, char *buf)
> +{
> +	struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> +
> +	return sysfs_emit(buf, "%d\n", pfdev->profile_mode);
> +}
> +
> +

Dropped the extra blank and queued the patch to drm-misc-next.

> +static ssize_t profiling_store(struct device *dev,
> +			       struct device_attribute *attr,
> +			       const char *buf, size_t len)
> +{
> +	struct panfrost_device *pfdev =3D dev_get_drvdata(dev);
> +	bool value;
> +	int err;
> +
> +	err =3D kstrtobool(buf, &value);
> +	if (err)
> +		return err;
> +
> +	pfdev->profile_mode =3D value;
> +
> +	return len;
> +}

