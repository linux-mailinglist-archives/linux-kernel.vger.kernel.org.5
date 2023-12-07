Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F89807F0F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 04:09:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbjLGDJm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 22:09:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGDJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 22:09:40 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC102110
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 19:09:46 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id d75a77b69052e-4258b6df295so159211cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 19:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701918585; x=1702523385; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KonfnbxwpH3x3CnjOO6Ekc8vtvdBCrnjbKjN44bF6c=;
        b=UPAsSRh1vo8nGHfs9k024dfH2iM8PMgAA03+Se8jTuMMMUpTHs+/a9vU6g1cA+6gKM
         L7/g5rCZA8WO2Xn3fgYyhVIsJRUHHLcWJHtvOm+JeoDZF4F1IucuTCArQnFk1aAd/hwE
         9oyqWJR0H5NQNPUjHE5eMR1T5z4DkHEODUOPk/KPzLT7Kyb03jLzV9WZQ1GSYieJpFH3
         NrakQKA70/AX3B33RTtjb23YhVecsO0sd+AaNfnIf5tszxDXM8aWaUVDDYZQy8S+6Imp
         c7SsrELIcCkpB/Ct9g+cZad8r9bMXUySU0QRwVVmW+f4+SirvQmodEyzpU1frZH8T/Ot
         wwrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701918585; x=1702523385;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KonfnbxwpH3x3CnjOO6Ekc8vtvdBCrnjbKjN44bF6c=;
        b=Czs2tpGLD3yNz7qJQSKJr0DlnHdUrLo9NDnBlwA6BAbSUBaW7ktmoqPuAVe2hqUU/T
         Z/B6GnJFo9iqFe9U63LLJoHh5fXdLPgIiEJGdJ2VEYmruJ4gi+itlif3RMW2Ef2jWArq
         Ncbh0hd+Ja5u06Nnc9jNVRnC20Nc+flmhoj81ooBjTcoY0kWeadAYveOz0D4T5ek1D2L
         2q98mfuqWC9Kg4r21C/3Kq0oYd84+vuWJu60mxOQ/QC1sAec99I3AHR/Xqx8DU4cv7Vt
         kj7IVhYH9E7FLBAhlDabumH74Eqjo9SM4BmjDM1Bq4U0yTxVs0Y8v5EL9PyO00EHlurM
         9XUQ==
X-Gm-Message-State: AOJu0YwH6PCDviIm9T7qFZMk7y/eOG5rx7+BuLOg/fJ8ffURPiUlSo0j
        VxSf7tAXW+tOLtSCl9eZSLtjkn0XIBJYmBAO2SD/SQ==
X-Google-Smtp-Source: AGHT+IHmC2Uvlc1PpPCCKnWzQ2+wlWdVLitp/t35SGYTLb9vq9VLkXz76RklY+9U+4ePYTBrzENcbeKOcDj5pVG/+xQ=
X-Received: by 2002:ac8:4255:0:b0:425:75cf:90e9 with SMTP id
 r21-20020ac84255000000b0042575cf90e9mr398357qtm.22.1701918585052; Wed, 06 Dec
 2023 19:09:45 -0800 (PST)
MIME-Version: 1.0
References: <20231130174126.688486-1-herve.codina@bootlin.com> <20231206171540.GA2697853-robh@kernel.org>
In-Reply-To: <20231206171540.GA2697853-robh@kernel.org>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 6 Dec 2023 19:09:06 -0800
Message-ID: <CAGETcx-F8G3dcN-VTMrbya_=19zXP=S2ORA_qZqy+yND7S41_Q@mail.gmail.com>
Subject: Re: [PATCH 0/2] Synchronize DT overlay removal with devlink removals
To:     Rob Herring <robh@kernel.org>
Cc:     Herve Codina <herve.codina@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Lizhi Hou <lizhi.hou@amd.com>, Max Zhen <max.zhen@amd.com>,
        Sonal Santan <sonal.santan@amd.com>,
        Stefano Stabellini <stefano.stabellini@xilinx.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 6, 2023 at 9:15=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Thu, Nov 30, 2023 at 06:41:07PM +0100, Herve Codina wrote:
> > Hi,
>
> +Saravana for comment

I'll respond to this within a week -- very swamped at the moment. The
main thing I want to make sure is that we don't cause an indirect
deadlock with this wait(). I'll go back and look at why we added the
work queue and then check for device/devlink locking issues.

-Saravana

>
> Looks okay to me though.
>
> >
> > In the following sequence:
> >   of_platform_depopulate(); /* Remove devices from a DT overlay node */
> >   of_overlay_remove(); /* Remove the DT overlay node itself */
> >
> > Some warnings are raised by __of_changeset_entry_destroy() which  was
> > called from of_overlay_remove():
> >   ERROR: memory leak, expected refcount 1 instead of 2 ...
> >
> > The issue is that, during the device devlink removals triggered from th=
e
> > of_platform_depopulate(), jobs are put in a workqueue.
> > These jobs drop the reference to the devices. When a device is no more
> > referenced (refcount =3D=3D 0), it is released and the reference to its
> > of_node is dropped by a call to of_node_put().
> > These operations are fully correct except that, because of the
> > workqueue, they are done asynchronously with respect to function calls.
> >
> > In the sequence provided, the jobs are run too late, after the call to
> > __of_changeset_entry_destroy() and so a missing of_node_put() call is
> > detected by __of_changeset_entry_destroy().
> >
> > This series fixes this issue introducing device_link_wait_removal() in
> > order to wait for the end of jobs execution (patch 1) and using this
> > function to synchronize the overlay removal with the end of jobs
> > execution (patch 2).
> >
> > Best regards,
> > Herv=C3=A9
> >
> > Herve Codina (2):
> >   driver core: Introduce device_link_wait_removal()
> >   of: overlay: Synchronize of_overlay_remove() with the devlink removal=
s
> >
> >  drivers/base/core.c    | 26 +++++++++++++++++++++++---
> >  drivers/of/overlay.c   |  6 ++++++
> >  include/linux/device.h |  1 +
> >  3 files changed, 30 insertions(+), 3 deletions(-)
> >
> > --
> > 2.42.0
> >
