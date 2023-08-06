Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 941A677158F
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 16:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbjHFOSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 10:18:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjHFOSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 10:18:05 -0400
Received: from out203-205-251-53.mail.qq.com (out203-205-251-53.mail.qq.com [203.205.251.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF2A312A
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 07:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1691331479;
        bh=km0RHk7GmUg0c0pMnKkJEFCFmmqVKFM2uZzWPDD58UM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=ZaxaW+7+Pf8Boi+yj31MGmbFM9Anr1pQDZyBWvt3WEAiAaklhjGyjjc7YtAA9iSse
         9Bv/1D2vOvHEdCEZ/LrKSaJ9z4reYNiwMY8rOyR4FXZ7qG+GMHh+/nlXezCgP9bAr4
         cv6qDwp1HSpk7QnxS2zzsTxY5FwVplbnu3xoQn90=
Received: from localhost.localdomain ([220.243.131.5])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id 2EBA0A76; Sun, 06 Aug 2023 22:11:43 +0800
X-QQ-mid: xmsmtpt1691331103t1e48yjzc
Message-ID: <tencent_942CC5C35E410E3545C2E386BE566B8B1405@qq.com>
X-QQ-XMAILINFO: M7dxyDFn9MPmJaJLhUnyC7r5FWNexqHHySU8S2U4Z7TPYOtNOAKnKcJ9dqZOwd
         lgAnZ2tVgPLE7IZeQYWLsjZgw6vdLOGkWm/5COii/VEHBMEhlToKLGIvKiVz9qzykkavo+DlZsqf
         0guPTcuiezm0skj2HvDkrOWVSCUbsIAdwo29bBeRdhxDaqpmRzJLYk3KGvvi4p2dVhQo0O+SrYtM
         GGFd1z8X/XFkGQ8fcEzy6mztNnzuHY/YA/ylJJOPgikPvkNZduk526PT007LaFUcvxlnu22ruHxn
         s7DOScOEumy/OILPnLg8G/BXADN/CzrGtbDIASJzRx72jYi3LAcdtPHNVQwLhf15nYH1peB3lqzR
         2GbNn7yGXt52iSOu9gPqmdMvclk2j8tqGR3PtKWUEnlD86b+KYqWWG9ADWkMsbniRKdf2eHrhIFV
         zoaT4lk5/tnVDH2HVkyYN2FlXE87zsjqxp5tdRFyiAwydw1+msoK8dK9o1UzhjAY7eUumByYP6/W
         rwl8KSUiDg3gft8ovg1ngKEh2+ZvO3nJgwBU/K1PULjXkWM9pFVYIVFILLNmwFGh04/Kcy7k7TSt
         mI/Eceh8Uuf16c8xpcnNKD4zzJuSQJBZ4DAe97OeL1i9bjJAwbVC+YI7S5Z/8u0yePYlQRXoKbu4
         d+tyAA8XcpS5/HNsylZdjSb5OXuyLfp9r986nkqbN1Fn4Y9wuCPcJMsqAZaMoBegotNCI2jPL62U
         hzHqpLV19IUU/nCdPopPCxpGW0/gtN1VFiBeSoOySsLCEJZiIFogDAFPbAQNpz4rc8gWfBtZJXwd
         tlaH3tpWZywC3qFWT4irI7DwFR1AJCDfZ/6JiQ8qkV9k4qKLHanjh9ARH/G3ukHRtZyoa9gU8HkX
         r4TCLL53xLqYyNKG/pk42+1GxTa2Rseh7xgVv/1ZQRjpyW3lurm/7lfqy+VWWUyAZisHhvcl2J9g
         gZH/5whqS/chq8ZRf+vUBKPTlpZfJs553a43LFOa4=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jgross@suse.com, xen-devel@lists.xenproject.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] xen: fix potential shift out-of-bounds in xenhcd_hub_control()
Date:   Sun, 06 Aug 2023 22:11:43 +0800
X-OQ-MSGID: <5974189.lOV4Wx5bFT@localhost.localdomain>
In-Reply-To: <4825193.GXAFRqVoOG@localhost.localdomain>
References: <tencent_15DD79B42AD8A0D64A7CDC24D4FE6C85800A@qq.com>
 <2023062628-shame-ebook-56f2@gregkh>
 <4825193.GXAFRqVoOG@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023=E5=B9=B47=E6=9C=881=E6=97=A5=E6=98=9F=E6=9C=9F=E5=85=AD CST =
=E4=B8=8B=E5=8D=8811:51:43=EF=BC=8CZhang Shurong =E5=86=99=E9=81=93=EF=BC=9A
> =E5=9C=A8 2023=E5=B9=B46=E6=9C=8826=E6=97=A5=E6=98=9F=E6=9C=9F=E4=B8=80 C=
ST =E4=B8=8B=E5=8D=881:52:02=EF=BC=8C=E6=82=A8=E5=86=99=E9=81=93=EF=BC=9A
>=20
> > On Mon, Jun 26, 2023 at 07:48:05AM +0200, Jan Beulich wrote:
> > > On 25.06.2023 18:42, Zhang Shurong wrote:
> > > > --- a/drivers/usb/host/xen-hcd.c
> > > > +++ b/drivers/usb/host/xen-hcd.c
> > > > @@ -456,6 +456,8 @@ static int xenhcd_hub_control(struct usb_hcd *h=
cd,
> > > > __u16 typeReq, __u16 wValue,> >
> > > >=20
> > > >  			info->ports[wIndex - 1].c_connection =3D
>=20
> false;
>=20
> > > >  			fallthrough;
> > > >  	=09
> > > >  		default:
> > > > +			if (wValue >=3D 32)
> > > > +				goto error;
> > > >=20
> > > >  			info->ports[wIndex - 1].status &=3D ~(1
>=20
> << wValue);
>=20
> > > Even 31 is out of bounds (as in: UB) as long as it's 1 here rather
> > > than 1u.
> >=20
> > Why isn't the caller fixed so this type of value could never be passed
> > to the hub_control callback?
> >=20
> > thanks,
> >=20
> > greg k-h
>=20
> Although I'm not knowledgeable about the USB subsystem, I've observed that
> not all driver code that implements hub_control callback performs a shift
> operation on wValue, and not all shift operations among them cause
> problems. Therefore, I've decided to fix this issue within each driver
> itself.
>=20
> For example, in r8a66597_hub_control, it will first check whether wValue =
is
> valid (always < 31) before the shift operation. In case of an invalid
> number, the code would execute the error branch instead of the shift
> operation.
>=20
> switch (wValue) {
> case USB_PORT_FEAT_ENABLE:
> 	rh->port &=3D ~USB_PORT_STAT_POWER;
> 	break;
> case USB_PORT_FEAT_SUSPEND:
> 	break;
> case USB_PORT_FEAT_POWER:
> 	r8a66597_port_power(r8a66597, port, 0);
> 	break;
> case USB_PORT_FEAT_C_ENABLE:
> case USB_PORT_FEAT_C_SUSPEND:
> case USB_PORT_FEAT_C_CONNECTION:
> case USB_PORT_FEAT_C_OVER_CURRENT:
> case USB_PORT_FEAT_C_RESET:
> 	break;
> default:
> 	goto error;
> }
> rh->port &=3D ~(1 << wValue);

Hi there. I apologize for reaching out once more. I'm feeling a bit puzzled=
=20
about what my next step should be. I'm unsure whether I should rewrite this=
=20
patch or attempt to address the issue at the caller level.


