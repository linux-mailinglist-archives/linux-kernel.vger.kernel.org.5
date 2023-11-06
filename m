Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724FE7E2D10
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 20:39:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjKFTjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 14:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232370AbjKFTjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 14:39:06 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C7D5324E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 11:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=JuqnuRe3T4IrOKd4fucdLTe1sfL1ooz3/rjulIV0zVA=;
        t=1699299459; x=1700509059; b=qPYiiNkQIbLisRbQaZQxg2kNSRUDJUqqnzoyd52PC+AMVHL
        B7selDM+2iE0qdPz05/Kr59mJZLLNpiMUnRRrBQVLGKE7Z0HAOwWw+J37s8uteH/24+qbeXTCZ+PV
        Y2rgD9Kfv2TCV56D4UTSlgpIdXiOMFoidTQ5gCW3Q7rhUo+evBEMpsfgH6EPnkvB6GY3uXbFwGtRT
        k7VWBtEWTwpAc3cmONZcfj73wet8fJLIiaiolu32/rRPF++4kwQwph494O2Bi5tyCrgV40xjzij6m
        PTfjpZL6OWBLLfm1wSvNdCUFQybVf2c2x+a3V0ufNrBUYgxMT0FruoxygH8kT9Kg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1r05Pi-0000000FrFj-2GOH;
        Mon, 06 Nov 2023 20:37:34 +0100
Message-ID: <c4abc49c31643baa34bf889d689e8c587c28da54.camel@sipsolutions.net>
Subject: Re: [PATCH] devcoredump: Send uevent once devcd is ready
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Mukesh Ojha <quic_mojha@quicinc.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 06 Nov 2023 20:37:33 +0100
In-Reply-To: <2023110659-december-cranium-c98e@gregkh>
References: <1699280735-31482-1-git-send-email-quic_mojha@quicinc.com>
         <2023110659-december-cranium-c98e@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-11-06 at 20:36 +0100, Greg KH wrote:
> On Mon, Nov 06, 2023 at 07:55:35PM +0530, Mukesh Ojha wrote:
> > dev_coredumpm() creates a devcoredump device and adds it
> > to the core kernel framework which eventually end up
> > sending uevent to the user space and later creates a
> > symbolic link to the failed device. An application
> > running in userspace may be interested in this symbolic
> > link to get the name of the failed device.
> >=20
> > In a issue scenario, once uevent sent to the user space
> > it start reading '/sys/class/devcoredump/devcdX/failing_device'
> > to get the actual name of the device which might not been
> > created and it is in its path of creation.
> >=20
> > To fix this, suppress sending uevent till the failing device
> > symbolic link gets created and send uevent once symbolic
> > link is created successfully.
> >=20
> > Signed-off-by: Mukesh Ojha <quic_mojha@quicinc.com>
>=20
> What commit id does this fix?=C2=A0
>=20

I guess the original introduction.

>  What in-kernel driver does this affect
> that is using devcoredump?
>=20

All of them really, it's really about how fast userspace is to access it
after the event.

Looks fine to me, FWIW, but a Fixes tag wouldn't hurt.

johannes
