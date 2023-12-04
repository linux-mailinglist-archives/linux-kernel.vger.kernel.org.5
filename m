Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D8FA8034F8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:32:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233931AbjLDNcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:32:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233683AbjLDNcH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:32:07 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02B14A1;
        Mon,  4 Dec 2023 05:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701696734; x=1733232734;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=3MyO9NwNF8iBWDVZhORikLjFXXFCiB1N83KdroXgP7w=;
  b=CE7vX6It1L1FNauHl7D56L6gen1xIVNyRz4h9JJ6oSjs7KFAWwU+KzNZ
   pjLjbLYzPKLe805kP9RYgRlPC25KaEavfS4cSHou+7GYd3seAiHe0mDDl
   ZviUez/5uIbVm66sWJyKebTEN7m0hVgY24Rc8peq7X7+timCf065+OAby
   VOfJslh/e+9ShKREvDbAk8pyWyHlyQlk0UxAF7FsO5iVwLu5jkrJLnjoQ
   a/ywQ5BIQc43A8suv2uhpN6eXyOMdEGCiDNQ7A7tm7PcL+ZK6iVZ5zl31
   +qcWlM+GtOQlKwatEEO+YBWrJBJsq9W3ipg4yD4AlKwIXu+OsGTvAIkZF
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="581857"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="581857"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:31:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="11963599"
Received: from jjstacey-mobl2.amr.corp.intel.com (HELO [10.213.160.16]) ([10.213.160.16])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:31:52 -0800
Message-ID: <fe19e1f52f783d5a27981abcae649ce52bd076f9.camel@linux.intel.com>
Subject: Re: [PATCH v2] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Jiri Kosina <jkosina@suse.com>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     benjamin.tissoires@redhat.com, linux-pm@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Jian Hui Lee <jianhui.lee@canonical.com>,
        Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Mon, 04 Dec 2023 08:31:49 -0500
In-Reply-To: <nycvar.YFH.7.76.2312041331050.29220@cbobk.fhfr.pm>
References: <20231108121940.288005-1-kai.heng.feng@canonical.com>
         <nycvar.YFH.7.76.2312041331050.29220@cbobk.fhfr.pm>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-12-04 at 13:31 +0100, Jiri Kosina wrote:
> On Wed, 8 Nov 2023, Kai-Heng Feng wrote:
>=20
> > Since PCI core and ACPI core already handles PCI PME wake and GPE
> > wake
> > when the device has wakeup capability, use device_init_wakeup() to
> > let
> > them do the wakeup setting work.
> >=20
> > Also add a shutdown callback which uses pci_prepare_to_sleep() to
> > let
> > PCI and ACPI set OOB wakeup for S5.
> >=20
> > Cc: Jian Hui Lee <jianhui.lee@canonical.com>
> > Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
>=20
> Srinivas, do you please have any feedback on this patch?
Sorry, slipped out of my review list. I will send today.

Thanks,
Srinivas

>=20
> Thanks,
>=20

