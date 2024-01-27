Return-Path: <linux-kernel+bounces-41329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D773183EEE1
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 18:00:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94640283947
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 17:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF6352D022;
	Sat, 27 Jan 2024 17:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GVxI6YaW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D533D6C;
	Sat, 27 Jan 2024 16:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706374800; cv=none; b=L6RpKqX1F9YmF1SBVrPGQKfhfsTNmyn1wKOL7idU1Hx1b23fDxfJIa9bBstupPs0K/YPZcFfWps/2SpuiP4aY2iz/u2Pylmgr3UJrF+BgaKkJKUqA17K2pKje3Dar001zRln2+ByzRIOKm9L+s7aT6lTsV323sH37oIJ2n4Bu0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706374800; c=relaxed/simple;
	bh=BFE+oUT3JbsGFF6ooIXLXk7qKZNWepxiyzsKwqSwJqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ldP+qRJ6MLX8b9hZMJTcIgHPbgN2X9Z+cNcOf76XdjYis46e6rgZsep/OLPBbgo6RnvnVLu1ytw1GrbZ4uE9RmIx2txOEKsZwBE2u/pzjJYQiZ9KMuEQCxbw8fw0m51TD/qQgnaVBQ5WbFtYpty9STPrR8P23WG9JvYPhOlLi6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GVxI6YaW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38D87C433C7;
	Sat, 27 Jan 2024 16:59:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706374799;
	bh=BFE+oUT3JbsGFF6ooIXLXk7qKZNWepxiyzsKwqSwJqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=GVxI6YaWHJ7Eb3NGUnV/awL+qw2jyKxOAW/2iO0/uY3I/td2sMqhyJM+KuimsYPgJ
	 drFbdMEe3A/uAm3jCC6m31kkC4ZIMUM4ov4/5Rff4ztCnQMCMmBmRCVBnRdm6YaUxO
	 i8nAY0vE65U9VbbDRtqeCwzOL2Glteho6l6IROQuLxK7cj8yWxxMO9a2p7Ekup+DKp
	 VFaBfHxrq0V/QXq4fAiQtF9bqtr+JWLd2hM2gD/bnZplJWy7JKEcPyY9tiGGFQ+Sud
	 wBuV7RWMM2TrZ1EEp1jaQxnkDCXWz9nRzIhVXL8K32E5gmzxLHrYtAuVH5m6y4q8bu
	 yBqjJssTlXNWA==
Date: Sat, 27 Jan 2024 16:59:48 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Petre Rodan <petre.rodan@subdimension.ro>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>
Subject: Re: [PATCH v2 4/4] iio: pressure: hsc030pa add triggered buffer
Message-ID: <20240127165948.518a9ca0@jic23-huawei>
In-Reply-To: <20240127160405.19696-5-petre.rodan@subdimension.ro>
References: <20240127160405.19696-1-petre.rodan@subdimension.ro>
	<20240127160405.19696-5-petre.rodan@subdimension.ro>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.40; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 27 Jan 2024 18:03:58 +0200
Petre Rodan <petre.rodan@subdimension.ro> wrote:

> Add triggered buffer feature.
> 
> Signed-off-by: Petre Rodan <petre.rodan@subdimension.ro>

Rest of series looks fine to me, but I'll leave it on list for
a few days at least for others to comment.

Thanks,

Jonathan


