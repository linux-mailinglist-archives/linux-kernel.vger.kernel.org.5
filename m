Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BBC7B55E0
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:02:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237904AbjJBO46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236077AbjJBO45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:56:57 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4674D9D;
        Mon,  2 Oct 2023 07:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696258615; x=1727794615;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=aPqn7WA3jprZ9fO+vDm8nGuTiboKhxPEKwpfSAuH2cE=;
  b=P5uiD6PIo+8/gSjekXfMJRQKFO+W0p5eHSh29uSnxOvT6Gz3aYKIghUY
   bNnq3Th1V/pdultzICKsOA7UwI0m/URSAOonfLX7ghQVIiWXwAziS7Ulj
   Xndew6M2nCkdQrVtnUZiFuI0pP9VGxV/cUOpOQBw1heM6GLL68eZpKlPz
   TH4Kpw1yWYD9uTo6RFDVBflrLO2mAOAyJ2Rf4zLhLYi5BDH84VlyQ071x
   UN2FX4MKhxXG5t1NzHyAXkELYqvbxWjkqjHP0Hn9HErAI51worEJ8Ep6N
   9ztvCuuQtog4OzOS8c9kOsQ8c8xuWEyXV7/93/ek1ggOgyvrY3KYCw3N4
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="468936198"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="468936198"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 07:56:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="785802123"
X-IronPort-AV: E=Sophos;i="6.03,194,1694761200"; 
   d="scan'208";a="785802123"
Received: from spandruv-desk.jf.intel.com (HELO spandruv-desk.amr.corp.intel.com) ([10.54.75.14])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 07:56:54 -0700
Message-ID: <947fa59b11df09de2734d2f9cdeaf69590f30a51.camel@linux.intel.com>
Subject: Re: [PATCH 2/3] platform/x86: ISST : Check major minor version
From:   srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To:     Ilpo =?ISO-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Date:   Mon, 02 Oct 2023 07:56:54 -0700
In-Reply-To: <4098d4a2-f672-3c72-5ddd-b397e2ed1465@linux.intel.com>
References: <20230925194338.966639-1-srinivas.pandruvada@linux.intel.com>
          <20230925194338.966639-3-srinivas.pandruvada@linux.intel.com>
          <f82fcfc9-eb41-56cb-93e1-abf9cf7413@linux.intel.com>
          <72a2766bc7bb4f9d6b3d5f2ff114f0af1b6646a4.camel@linux.intel.com>
         <45625e9e-997b-eba1-413a-43a7d835feb@linux.intel.com>
         <daa44585c4a57b8823cb260d9ec9bd3f59f410c6.camel@linux.intel.com>
         <4098d4a2-f672-3c72-5ddd-b397e2ed1465@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-3.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-10-02 at 17:24 +0300, Ilpo J=C3=A4rvinen wrote:
> On Mon, 2 Oct 2023, srinivas pandruvada wrote:
>=20
> > On Mon, 2023-10-02 at 16:49 +0300, Ilpo J=C3=A4rvinen wrote:
> > > On Sat, 30 Sep 2023, srinivas pandruvada wrote:
> > >=20
> > > > On Fri, 2023-09-29 at 17:28 +0300, Ilpo J=C3=A4rvinen wrote:
> > > > > On Mon, 25 Sep 2023, Srinivas Pandruvada wrote:
> > > > >=20
> > > > > > Parse major and minor version number from the version
> > > > > > field. If
> > > > > > there
> > > > > > is a mismatch for major version, exit from further
> > > > > > processing
> > > > > > for
> > > > > > that
> > > > > > domain.
> > > > > >=20
> > > > > > If there is mismatch in minor version, driver continue to
> > > > > > process
> > > > > > with
> > > > > > an error message.
> > > > >=20
> > > > > This sentence sounds odd.
> > > > What is the suggestion here?
> > >=20
> > > These things sound wrong: It should be "continues"
> > OK
> >=20
> > > =C2=A0but I also find "to=20
> > > process" odd when lacking what it processes.
> >=20
> > Further processing means, whatever this driver is supposed to do.
> > You
> > don't want to fully explain again what this driver is doing.
>=20
> Well, whatever. I'm not a native anyway so I cannot really be the
> defining=20
> authority how the language gets used so feel free to leave "to
> process"=20
> as is.'

That is not my intention! I want to make it as good as possible. Let me
come up with new description.

Thanks,
Srinivas


>=20

