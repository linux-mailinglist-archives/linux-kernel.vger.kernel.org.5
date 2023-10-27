Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5CCB7D98D2
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 14:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345923AbjJ0MqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 08:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjJ0MqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 08:46:03 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940E81B9
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 05:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=H+PtxNveSYF0PZxJqK9VGUgEq1qARfXij9oa/0ZSPmk=;
        t=1698410761; x=1699620361; b=gkG884h1jaZryTMpfQBZ5SVVfNkP5DTYqO/lHqq/haKv+s/
        kXmCf0Yn5ScvTGJ4+rBRxzJ3hszbIpWiTSiH3o8TCMDSgZv2FFJapEmFdWd+1YMgmxBG4DSWIbfxX
        iGeEZXgcECN4UZlaPHdthTdc3u1dJWtboeEI3KZrOiTqHfSVHkgDR7uEGV9gmqVOIica+R+xY/pnh
        pdl+J1YnARscE2Ql/iqtFPh9zu5R0EDEuEwogqEfQYom/gNR2+n3lXgQNhxlP0AKW8Uf3y97WyIRu
        CBclun++AWS8cxaFZhznoEXkKF8sKnNs1IGJ7oi6g9odSP08y0ZQnqkxml1hRsUg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.97-RC1)
        (envelope-from <johannes@sipsolutions.net>)
        id 1qwMDu-00000004jWi-0We8;
        Fri, 27 Oct 2023 14:45:58 +0200
Message-ID: <22ab53d1ae36d4925732e6e1dc989dc75af126da.camel@sipsolutions.net>
Subject: Re: [PATCH] Devcoredump: fix use-after-free issue when releasing
 devcd device
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Yu Wang <quic_yyuwang@quicinc.com>
Cc:     rafael@kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com
Date:   Fri, 27 Oct 2023 14:45:57 +0200
In-Reply-To: <2023102730-twins-thieving-d04e@gregkh>
References: <20231027055521.2679-1-quic_yyuwang@quicinc.com>
         <2023102730-twins-thieving-d04e@gregkh>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2023-10-27 at 13:11 +0200, Greg KH wrote:
> >=20
> >     static void my_coredump()
> >     {
> >         struct my_coredump_state dump_state;
> >         struct device *new_device =3D
> >             kzalloc(sizeof(*new_device), GFP_KERNEL);
> >=20
> >         ...
> >         new_device->release =3D my_dev_release;
> >         device_initialize(new_device);
> >         ...
> >         device_add(new_device);
> >         ...
> >         init_completion(&dump_state.dump_done);
> >         dev_coredumpm(new_device, NULL, &dump_state, datalen, GFP_KERNE=
L,
> >                       my_coredump_read, my_coredump_free);
> >         wait_for_completion(&dump_state.dump_done);
> >         device_del(new_device);
> >         put_device(new_device);
> >     }
>=20
> Is there any in-kernel user like this?  If so, why not fix them up to
> not do this?
>=20

Maybe this is only a simplified scenario and whenever you remove a
device when a coredump is still pending this can happen?

Actually, no, wait, what is this doing??? Why is there a completion and
all that stuff there? You shouldn't really care about the dump once you
have created it, and not pass NULL for the struct module pointer
either?!

johannes
