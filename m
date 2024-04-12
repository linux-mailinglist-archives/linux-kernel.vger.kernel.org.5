Return-Path: <linux-kernel+bounces-142317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B3228A2A1E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 11:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CEA21F21842
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 09:02:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D0044F5E6;
	Fri, 12 Apr 2024 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DAv2t4tB"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56AE71F5FF;
	Fri, 12 Apr 2024 08:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712911583; cv=none; b=mfxpdTC5+CCqWJ27p1H6WmZsQhjkpVh82Z5e4jYKBEm6ahEAHi5sLMJOc3IUIg3vKb8JRi8jQZIDkO+L47Az/wcYGms084ZWJTkKP5m7JXSSBV4TYQKDlIBgImqCMN4rGsmjXKvVXrHxDBFLlV0bV4JcraMAMWtzOSIUclwsjsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712911583; c=relaxed/simple;
	bh=JYiphHL4aWeb5bCt/UV1zWvGBptIz8UmnhXbhfg1zTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T7mfqV5f3oq4OTbfNJEudLq8bGoYT9FxXoFd9qIClG4PNA0HQrfvLKlMHu9hcoSuCkOg+isngPD18Or26o9mDYnQFapSx7c4pFWPxIM+A2QTNf2Apnhmajx8yykZ3LXdNa7TYIMtNtH7a0ZfJXex/7N6qPNpY1LiApfPTsOXF/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DAv2t4tB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 090ECC2BD11;
	Fri, 12 Apr 2024 08:46:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712911582;
	bh=JYiphHL4aWeb5bCt/UV1zWvGBptIz8UmnhXbhfg1zTw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DAv2t4tBiTH6oMe2m0A6aAnIlkZtOLEHDJchzQJIN87/EqewzWvz9Dk9C1Df6MfuI
	 dSk686Q7PsOzpjW5ApoU8U5UIBioENvkDDbroaVwX2e2Fo4VMAfF0YV4YsSXuCJxhD
	 F3xJPaF4jmYM3SBGEVF9a4agJi6M1JHGxsfTZYCNC+C4y2uDlRqk6wtd8AnVdiJ17l
	 tKOI3EDbaaoFkWEDLvk2A16r3n913mOqilyzmndDEJyPc3rUncLxiZNTZDXoPuNddx
	 vZX4xyE9OXS5dBxO/nLzNapLWOHA6UfT1cKFoxKyIoJo5JWjDBBkZ0SpxLzIGnzh6E
	 5SdZgPhRm2fIg==
Date: Fri, 12 Apr 2024 09:46:16 +0100
From: Lee Jones <lee@kernel.org>
To: George Stark <gnstark@salutedevices.com>
Cc: andy.shevchenko@gmail.com, pavel@ucw.cz, vadimp@nvidia.com,
	christophe.leroy@csgroup.eu, hdegoede@redhat.com,
	mazziesaccount@gmail.com, peterz@infradead.org, mingo@redhat.com,
	will@kernel.org, longman@redhat.com, boqun.feng@gmail.com,
	nikitos.tr@gmail.com, marek.behun@nic.cz, kabel@kernel.org,
	linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel@salutedevices.com
Subject: [GIT PULL] Immutable branch between LEDs and Locking due for the
 v6.10 merge window
Message-ID: <20240412084616.GR2399047@google.com>
References: <20240411161032.609544-1-gnstark@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240411161032.609544-1-gnstark@salutedevices.com>

Enjoy!

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/leds.git ib-leds-locking-v6.10

for you to fetch changes up to c382e2e3eccb6b7ca8c7aff5092c1668428e7de6:

  leds: an30259a: Use devm_mutex_init() for mutex initialization (2024-04-11 17:35:24 +0100)

----------------------------------------------------------------
Immutable branch between LEDs and Locking due for the v6.10 merge window

----------------------------------------------------------------
George Stark (8):
      locking/mutex: Introduce devm_mutex_init()
      leds: aw2013: Use devm API to cleanup module's resources
      leds: aw200xx: Use devm API to cleanup module's resources
      leds: lp3952: Use devm API to cleanup module's resources
      leds: lm3532: Use devm API to cleanup module's resources
      leds: nic78bx: Use devm API to cleanup module's resources
      leds: mlxreg: Use devm_mutex_init() for mutex initialization
      leds: an30259a: Use devm_mutex_init() for mutex initialization

 drivers/leds/leds-an30259a.c | 14 ++++----------
 drivers/leds/leds-aw200xx.c  | 32 +++++++++++++++++++++-----------
 drivers/leds/leds-aw2013.c   | 25 +++++++++++++------------
 drivers/leds/leds-lm3532.c   | 29 +++++++++++++++++------------
 drivers/leds/leds-lp3952.c   | 21 +++++++++++----------
 drivers/leds/leds-mlxreg.c   | 14 +++++---------
 drivers/leds/leds-nic78bx.c  | 23 +++++++++++++----------
 include/linux/mutex.h        | 27 +++++++++++++++++++++++++++
 kernel/locking/mutex-debug.c | 12 ++++++++++++
 9 files changed, 123 insertions(+), 74 deletions(-)

-- 
Lee Jones [李琼斯]

