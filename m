Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C3B80AE89
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 22:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbjLHVCz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 16:02:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjLHVCx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 16:02:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7BD61734
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 13:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702069378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wnR71ERwB0xpUeMudALkEkT2aBnLdTFV83wSZKWUuyk=;
        b=Aec1e1okdM02CCFdcdf/QXgi2L86Y+BK4EBoitm+xghQ6wj0hjqR40CCOunqmrshQ9VNJ9
        K7YLYwz7+NlbpbZ4p4a8BKp2n3/ubjpig6kO8T/jvsiIM6RH/TukpIe/nupy5IJSK5fqHF
        VRyX0xW3F7943bwbmYHVQ+zxzU6pmnM=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-Z5GfHPbHOrikACI7rlVoCg-1; Fri, 08 Dec 2023 16:02:56 -0500
X-MC-Unique: Z5GfHPbHOrikACI7rlVoCg-1
Received: by mail-oa1-f72.google.com with SMTP id 586e51a60fabf-1faf33fe0easo4425215fac.0
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 13:02:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702069375; x=1702674175;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wnR71ERwB0xpUeMudALkEkT2aBnLdTFV83wSZKWUuyk=;
        b=gzIHg5kNoZz/fwr+4MRIKM03pmPrMe8Y//MC4MUhV8a6vnbj0P0Ol4YoTFqLH+EFkT
         6l6JvwY1TJLWvbE+Pj4fjIZnaiYPp0ReXKdI9i9f5jBu6zIIicZiDsGSXKhuaGTiBlpu
         0EiCJOiAtjPSlcxxAUkp4e92tNyvIRDzro24yPaiKgtLjnX3EERN+fB8V2SK20ybhQQm
         XzR5kpkYLfalKPFpY9T42+VigUNUWRjujwguTiHyP0pKNn6ic1QkruwKk5FTqGbtAhOe
         CNGGpGmxjfv9lg9H4hwMaNr+crYhmcp1iBqbKK1l3kaQnZ5JZxSDIeB7y3yxxxWHQLMS
         /E6A==
X-Gm-Message-State: AOJu0YzkVYVU7Y7vEpXJubJywtvCcW3ihrQ7SyAvQTAEjASUzwteWNbV
        YXs+eZfLtyxBcrHHYSLTuE1gmESaapZI3pfKJO8Y5MwJOWbJasDD3EqvKB3uGzAVFvUZ2MQMkrQ
        npDDBvpoEkljlmdVnZMwvIY5T/8MgHrt/vX4VTsmi
X-Received: by 2002:a05:6871:5812:b0:1fa:6f5:7b11 with SMTP id oj18-20020a056871581200b001fa06f57b11mr831747oac.36.1702069375681;
        Fri, 08 Dec 2023 13:02:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG70CYCSZWB6DKvr4hrnjBebC5sVpU0c4XwqZCNGpXXRnlou5CpzlriTsL34en/4bO5Edgmdws7P7mWyGAfy2s=
X-Received: by 2002:a05:6871:5812:b0:1fa:6f5:7b11 with SMTP id
 oj18-20020a056871581200b001fa06f57b11mr831732oac.36.1702069375461; Fri, 08
 Dec 2023 13:02:55 -0800 (PST)
MIME-Version: 1.0
References: <20231115125111.28217-1-imbrenda@linux.ibm.com> <CABgObfYt3VH-zPwT1whA0N7uE2ioq9GznTt-QhnES8B5tX76jQ@mail.gmail.com>
In-Reply-To: <CABgObfYt3VH-zPwT1whA0N7uE2ioq9GznTt-QhnES8B5tX76jQ@mail.gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Date:   Fri, 8 Dec 2023 22:02:43 +0100
Message-ID: <CABgObfYVfNsfjy36iBeq7qiV_m3smRKCyOSWQRV2E0OMH1bqAA@mail.gmail.com>
Subject: Re: [GIT PULL v1 0/2] KVM: s390: two small but important fixes
To:     Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        borntraeger@de.ibm.com, hca@linux.ibm.com, agordeev@linux.ibm.com,
        gor@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 8, 2023 at 7:13=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com> =
wrote:
> >       KVM: s390/mm: Properly reset no-dat

A small question on this one, would it make sense to clear _all_
gmap-related bits, including _PGSTE_GPS_ZERO?

Paolo

