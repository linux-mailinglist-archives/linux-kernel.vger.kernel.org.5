Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B764D7D671E
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 11:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbjJYJm5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 05:42:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbjJYJmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 05:42:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9173F9D
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1698226923;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rM4ED7GZcY2szaoTQ6CTpdR7CfxOuwD/iAsYdHgxgfY=;
        b=UdWQ5qh8SKvfjJRMR+MZvOOks9Mmj/MH/kabsbI5ovaoCrcIQmQMsCLv6ETuWGi2DmjWH0
        ZZyQbcMvj3BwWFqqRKyC33fQKTEt/Lk5ZdLaMtuvkhEr3+rhkNBhqfQxGCIE7dgW3cnRK6
        aFIX4+bNkl3irSIVi5t8LsTcKPJmHoY=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-KQPDtPV2OvSGrWkP3OeEJA-1; Wed, 25 Oct 2023 05:42:01 -0400
X-MC-Unique: KQPDtPV2OvSGrWkP3OeEJA-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-53e1fe5b328so3550876a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 02:42:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698226920; x=1698831720;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rM4ED7GZcY2szaoTQ6CTpdR7CfxOuwD/iAsYdHgxgfY=;
        b=hZfun1jOgXX3tCS921L/qhiUIuSKDczyLCtyYkTTYhGtZWofM33l88jeFvAcoghNGv
         D+TKBrXzeH59QX4vdlwqlimLhnnahls5TFTF1L/keg3Xk5LnO+pn01Bg5J/T+lDhSbZv
         fkzi1ceFP0lyp3bvD22nRD3U9krI6+73vFgXVCwzj2+d68LdEBry5UdPsTkWQuRFhejX
         Zgd/m+K1rXtzfrAlrmiRCUl0WyqTl+2PN5Q0R17XdMqwJ280MD6DxjFQ8c4B8pB+Rpyx
         9SRurZkXfCauP2sUGlscUEqSKULG0PrZhJKmpr4HtfHQ+LvHZNeVysskWNQV9OcHkMxH
         4IvQ==
X-Gm-Message-State: AOJu0YwAOeJE7LiL22rZhp62qhv38YQBmNR1HKfXKNiBdSVPkVxnzhoM
        jV49z0C28qbKCSbRId2XwJEyp2zW9tmrIVsUXFjUQzWjMx8Fg6vFN2YUMgHKwWfiH/XpH/4xmUD
        pYUGukDyOLHycqwHrIXP28xkVl4vF+6ffNesnBSW8
X-Received: by 2002:a05:6402:354a:b0:53d:bc68:633d with SMTP id f10-20020a056402354a00b0053dbc68633dmr11630266edd.7.1698226920470;
        Wed, 25 Oct 2023 02:42:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHO0vlyW3p2KjMhlI20o7oRYIPFES37SBQlQ6WT+BXgUvPmqk47yt+17r5nshYMKYmbw4fPRKUVoF2npGI/TG8=
X-Received: by 2002:a05:6402:354a:b0:53d:bc68:633d with SMTP id
 f10-20020a056402354a00b0053dbc68633dmr11630244edd.7.1698226919995; Wed, 25
 Oct 2023 02:41:59 -0700 (PDT)
MIME-Version: 1.0
References: <1697880319-4937-1-git-send-email-si-wei.liu@oracle.com>
 <CACGkMEvkSFcHXC0HFw-NoDtDNnaucJbpfPO0Yho2r1QP8F6zSw@mail.gmail.com>
 <4d03661b-4289-46e7-8760-32a186783b73@oracle.com> <CAPpAL=za9VKy2csCPKOKHEKe3qGDQ=89n_08G_MWd7XMiNpUvQ@mail.gmail.com>
 <b5dadd3d-8806-4d72-90c4-ee1ba6446c3a@oracle.com>
In-Reply-To: <b5dadd3d-8806-4d72-90c4-ee1ba6446c3a@oracle.com>
From:   Lei Yang <leiyang@redhat.com>
Date:   Wed, 25 Oct 2023 17:41:23 +0800
Message-ID: <CAPpAL=yHDqn1AztEcN3MpS8o4M+BL_HVy02FdpiHN7DWd91HwQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/7] vdpa: decouple reset of iotlb mapping from device reset
To:     Si-Wei Liu <si-wei.liu@oracle.com>
Cc:     Jason Wang <jasowang@redhat.com>, mst@redhat.com,
        eperezma@redhat.com, sgarzare@redhat.com, dtatulea@nvidia.com,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000005181b60608874427"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000005181b60608874427
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2023 at 1:27=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.com> =
wrote:
>
Hello Si-Wei
> Thanks a lot for testing! Please be aware that there's a follow-up fix
> for a potential oops in this v4 series:
>
The first, when I did not apply this patch [1], I will also hit this
patch mentioned problem. After I applied this patch, this problem will
no longer to hit again. But I hit another issues, about the error
messages please review the attached file.
[1] https://lore.kernel.org/virtualization/1698102863-21122-1-git-send-emai=
l-si-wei.liu@oracle.com/

My test steps:
git clone https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.gi=
t
cd  linux/
b4 am 1697880319-4937-1-git-send-email-si-wei.liu@oracle.com
b4 am 20231018171456.1624030-2-dtatulea@nvidia.com
b4 am 1698102863-21122-1-git-send-email-si-wei.liu@oracle.com
git am ./v4_20231018_dtatulea_vdpa_add_support_for_vq_descriptor_mappings.m=
bx
git am ./v4_20231021_si_wei_liu_vdpa_decouple_reset_of_iotlb_mapping_from_d=
evice_reset.mbx
git am ./20231023_si_wei_liu_vhost_vdpa_fix_null_pointer_deref_in__compat_v=
dpa_reset.mbx
cp /boot/config-5.14.0-377.el9.x86_64 .config
make -j 32
make modules_install
make install

Thanks

Lei
> https://lore.kernel.org/virtualization/1698102863-21122-1-git-send-email-=
si-wei.liu@oracle.com/
>
> Would be nice to have it applied for any tests.
>
> Thanks,
> -Siwei
>
> On 10/23/2023 11:51 PM, Lei Yang wrote:
> > QE tested this series v4 with regression testing on real nic, there is
> > no new regression bug.
> >
> > Tested-by: Lei Yang <leiyang@redhat.com>
> >
> > On Tue, Oct 24, 2023 at 6:02=E2=80=AFAM Si-Wei Liu <si-wei.liu@oracle.c=
om> wrote:
> >>
> >>
> >> On 10/22/2023 8:51 PM, Jason Wang wrote:
> >>> Hi Si-Wei:
> >>>
> >>> On Sat, Oct 21, 2023 at 5:28=E2=80=AFPM Si-Wei Liu <si-wei.liu@oracle=
.com> wrote:
> >>>> In order to reduce needlessly high setup and teardown cost
> >>>> of iotlb mapping during live migration, it's crucial to
> >>>> decouple the vhost-vdpa iotlb abstraction from the virtio
> >>>> device life cycle, i.e. iotlb mappings should be left
> >>>> intact across virtio device reset [1]. For it to work, the
> >>>> on-chip IOMMU parent device could implement a separate
> >>>> .reset_map() operation callback to restore 1:1 DMA mapping
> >>>> without having to resort to the .reset() callback, the
> >>>> latter of which is mainly used to reset virtio device state.
> >>>> This new .reset_map() callback will be invoked only before
> >>>> the vhost-vdpa driver is to be removed and detached from
> >>>> the vdpa bus, such that other vdpa bus drivers, e.g.
> >>>> virtio-vdpa, can start with 1:1 DMA mapping when they
> >>>> are attached. For the context, those on-chip IOMMU parent
> >>>> devices, create the 1:1 DMA mapping at vdpa device creation,
> >>>> and they would implicitly destroy the 1:1 mapping when
> >>>> the first .set_map or .dma_map callback is invoked.
> >>>>
> >>>> This patchset is rebased on top of the latest vhost tree.
> >>>>
> >>>> [1] Reducing vdpa migration downtime because of memory pin / maps
> >>>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg953755.html
> >>>>
> >>>> ---
> >>>> v4:
> >>>> - Rework compatibility using new .compat_reset driver op
> >>> I still think having a set_backend_feature()
> >> This will overload backend features with the role of carrying over
> >> compatibility quirks, which I tried to avoid from. While I think the
> >> .compat_reset from the v4 code just works with the backend features
> >> acknowledgement (and maybe others as well) to determine, but not
> >> directly tie it to backend features itself. These two have different
> >> implications in terms of requirement, scope and maintaining/deprecatio=
n,
> >> better to cope with compat quirks in explicit and driver visible way.
> >>
> >>>    or reset_map(clean=3Dtrue) might be better.
> >> An explicit op might be marginally better in driver writer's point of
> >> view. Compliant driver doesn't have to bother asserting clean_map neve=
r
> >> be true so their code would never bother dealing with this case, as
> >> explained in the commit log for patch 5 "vhost-vdpa: clean iotlb map
> >> during reset for older userspace":
> >>
> >> "
> >>       The separation of .compat_reset from the regular .reset allows
> >>       vhost-vdpa able to know which driver had broken behavior before,=
 so it
> >>       can apply the corresponding compatibility quirk to the individua=
l
> >> driver
> >>       whenever needed.  Compared to overloading the existing .reset wi=
th
> >>       flags, .compat_reset won't cause any extra burden to the impleme=
ntation
> >>       of every compliant driver.
> >> "
> >>
> >>>    As it tries hard to not introduce new stuff on the bus.
> >> Honestly I don't see substantial difference between these other than t=
he
> >> color. There's no single best solution that stands out among the 3. An=
d
> >> I assume you already noticed it from all the above 3 approaches will
> >> have to go with backend features negotiation, that the 1st vdpa reset
> >> before backend feature negotiation will use the compliant version of
> >> .reset that doesn't clean up the map. While I don't think this nuance
> >> matters much to existing older userspace apps, as the maps should
> >> already get cleaned by previous process in vhost_vdpa_cleanup(), but i=
f
> >> bug-for-bug behavioral compatibility is what you want, module paramete=
r
> >> will be the single best answer.
> >>
> >> Regards,
> >> -Siwei
> >>
> >>> But we can listen to others for sure.
> >>>
> >>> Thanks
> >>>
>

--0000000000005181b60608874427
Content-Type: application/octet-stream; name=log
Content-Disposition: attachment; filename=log
Content-Transfer-Encoding: base64
Content-ID: <f_lo5k83xt0>
X-Attachment-Id: f_lo5k83xt0

WyA2MzI1LjQ2MjQyNl0gQlVHOiB1bmFibGUgdG8gaGFuZGxlIHBhZ2UgZmF1bHQgZm9yIGFkZHJl
c3M6IDAwMDAwMDAxMDA1YjRhZjQKWyA2MzI1LjQ2OTMwMV0gI1BGOiBzdXBlcnZpc29yIHJlYWQg
YWNjZXNzIGluIGtlcm5lbCBtb2RlClsgNjMyNS40NzQ0NDBdICNQRjogZXJyb3JfY29kZSgweDAw
MDApIC0gbm90LXByZXNlbnQgcGFnZQpbIDYzMjUuNDc5NTc3XSBQR0QgMTZhODBhMDY3IFA0RCAw
IApbIDYzMjUuNDgyODExXSBPb3BzOiAwMDAwIFsjMV0gUFJFRU1QVCBTTVAgTk9QVEkKWyA2MzI1
LjQ4NzE2OV0gQ1BVOiA0IFBJRDogNDAzODcgQ29tbTogcWVtdS1rdm0gTm90IHRhaW50ZWQgNi42
LjAtcmM3KyAjMwpbIDYzMjUuNDkzNjk1XSBIYXJkd2FyZSBuYW1lOiBEZWxsIEluYy4gUG93ZXJF
ZGdlIFI3NTAvMFBKODBNLCBCSU9TIDEuOC4yIDA5LzE0LzIwMjIKWyA2MzI1LjUwMTE3NV0gUklQ
OiAwMDEwOl9jb21wYXRfdmRwYV9yZXNldC5pc3JhLjArMHgyNy8weGIwIFt2aG9zdF92ZHBhXQpb
IDYzMjUuNTA3NzA4XSBDb2RlOiA5MCA5MCA5MCAwZiAxZiA0NCAwMCAwMCA0MSA1NSA0YyA4ZCBh
ZSAwOCAwMyAwMCAwMCA0MSA1NCA1NSA0OCA4OSBmNSA1MyA0YyA4YiBhNiAwMCAwMyAwMCAwMCA0
OCA4NSBmZiA3NCA0OSA0OCA4YiAwNyA0YyA4OSBlZiA8NDg+IDhiIDgwIDg4IDQ1IDAwIDAwIDQ4
IGMxIGU4IDA4IDQ4IDgzIGYwIDAxIDg5IGMzIGU4IDczIDVlIDliIGRjClsgNjMyNS41MjY0NTVd
IFJTUDogMDAxODpmZjczYTg1NzYyMDczYmEwIEVGTEFHUzogMDAwMTAyODYKWyA2MzI1LjUzMTY4
MV0gUkFYOiAwMDAwMDAwMTAwNWIwNTZjIFJCWDogZmYzMmIxM2NhNjk5NGM2OCBSQ1g6IDAwMDAw
MDAwMDAwMDAwMDIKWyA2MzI1LjUzODgxM10gUkRYOiAwMDAwMDAwMDAwMDAwMDAxIFJTSTogZmYz
MmIxM2MwNzU1OTAwMCBSREk6IGZmMzJiMTNjMDc1NTkzMDgKWyA2MzI1LjU0NTk0N10gUkJQOiBm
ZjMyYjEzYzA3NTU5MDAwIFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IGZmMzJiMTJjYTQ5N2Mw
ZjAKWyA2MzI1LjU1MzA3OV0gUjEwOiBmZjczYTg1NzYyMDczYzU4IFIxMTogMDAwMDAwMGMxMDZm
OWRlMyBSMTI6IGZmMzJiMTJjOTViMWQwNTAKWyA2MzI1LjU2MDIxMl0gUjEzOiBmZjMyYjEzYzA3
NTU5MzA4IFIxNDogZmYzMmIxMmQwZGRjNTEwMCBSMTU6IDAwMDAwMDAwMDAwMDgwMDIKWyA2MzI1
LjU2NzM0Nl0gRlM6ICAwMDAwN2ZlYzViOGNiZjgwKDAwMDApIEdTOmZmMzJiMTNiYmZjODAwMDAo
MDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMApbIDYzMjUuNTc1NDMyXSBDUzogIDAwMTAgRFM6
IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzClsgNjMyNS41ODExNzddIENSMjog
MDAwMDAwMDEwMDViNGFmNCBDUjM6IDAwMDAwMDAxNTY0NGEwMDMgQ1I0OiAwMDAwMDAwMDAwNzcz
ZWUwClsgNjMyNS41ODgzMDldIFBLUlU6IDU1NTU1NTU0ClsgNjMyNS41OTEwMjJdIENhbGwgVHJh
Y2U6ClsgNjMyNS41OTM0NzddICA8VEFTSz4KWyA2MzI1LjU5NTU4Ml0gID8gX19kaWUrMHgyMC8w
eDcwClsgNjMyNS41OTg2NTBdICA/IHBhZ2VfZmF1bHRfb29wcysweDc2LzB4MTcwClsgNjMyNS42
MDI2NjJdICA/IGV4Y19wYWdlX2ZhdWx0KzB4NjUvMHgxNTAKWyA2MzI1LjYwNjU4OF0gID8gYXNt
X2V4Y19wYWdlX2ZhdWx0KzB4MjIvMHgzMApbIDYzMjUuNjEwNzc1XSAgPyBfY29tcGF0X3ZkcGFf
cmVzZXQuaXNyYS4wKzB4MjcvMHhiMCBbdmhvc3RfdmRwYV0KWyA2MzI1LjYxNjY5Ml0gIHZob3N0
X3ZkcGFfb3BlbisweDU3LzB4MjgwIFt2aG9zdF92ZHBhXQpbIDYzMjUuNjIxNjYwXSAgPyBfX3Bm
eF9jaHJkZXZfb3BlbisweDEwLzB4MTAKWyA2MzI1LjYyNTc1OV0gIGNocmRldl9vcGVuKzB4YzYv
MHgyNjAKWyA2MzI1LjYyOTI1MF0gID8gX19wZnhfY2hyZGV2X29wZW4rMHgxMC8weDEwClsgNjMy
NS42MzMzNDldICBkb19kZW50cnlfb3BlbisweDE2ZS8weDUzMApbIDYzMjUuNjM3MTg5XSAgZG9f
b3BlbisweDIxYy8weDQwMApbIDYzMjUuNjQwNDIxXSAgcGF0aF9vcGVuYXQrMHgxMTEvMHgyOTAK
WyA2MzI1LjY0NDAwMF0gIGRvX2ZpbHBfb3BlbisweGIyLzB4MTYwClsgNjMyNS42NDc1ODJdICA/
IF9fY2hlY2tfb2JqZWN0X3NpemUucGFydC4wKzB4NWUvMHgxNDAKWyA2MzI1LjY1MjU0OF0gIGRv
X3N5c19vcGVuYXQyKzB4OTYvMHhkMApbIDYzMjUuNjU2MjEyXSAgX194NjRfc3lzX29wZW5hdCsw
eDUzLzB4YTAKWyA2MzI1LjY2MDA1MV0gIGRvX3N5c2NhbGxfNjQrMHg1OS8weDkwClsgNjMyNS42
NjM2MzFdICA/IHN5c2NhbGxfZXhpdF90b191c2VyX21vZGUrMHgyMi8weDQwClsgNjMyNS42Njg0
MjNdICA/IGRvX3N5c2NhbGxfNjQrMHg2OS8weDkwClsgNjMyNS42NzIxNzRdICA/IHN5c2NhbGxf
ZXhpdF90b191c2VyX21vZGUrMHgyMi8weDQwClsgNjMyNS42NzY5NzBdICA/IGRvX3N5c2NhbGxf
NjQrMHg2OS8weDkwClsgNjMyNS42ODA3MjFdICA/IGRvX3N5c2NhbGxfNjQrMHg2OS8weDkwClsg
NjMyNS42ODQ0NzNdICA/IHN5c2NhbGxfZXhpdF90b191c2VyX21vZGUrMHgyMi8weDQwClsgNjMy
NS42ODkyNjhdICA/IGRvX3N5c2NhbGxfNjQrMHg2OS8weDkwClsgNjMyNS42OTMwMjBdICA/IGV4
Y19wYWdlX2ZhdWx0KzB4NjUvMHgxNTAKWyA2MzI1LjY5Njk0NV0gIGVudHJ5X1NZU0NBTExfNjRf
YWZ0ZXJfaHdmcmFtZSsweDZlLzB4ZDgKWyA2MzI1LjcwMTk5OF0gUklQOiAwMDMzOjB4N2ZlYzVj
MzNlNjU0ClsgNjMyNS43MDU1NzZdIENvZGU6IDI0IDIwIGViIDhmIDY2IDkwIDQ0IDg5IDU0IDI0
IDBjIGU4IGI2IGQ1IGY1IGZmIDQ0IDhiIDU0IDI0IDBjIDQ0IDg5IGUyIDQ4IDg5IGVlIDQxIDg5
IGMwIGJmIDljIGZmIGZmIGZmIGI4IDAxIDAxIDAwIDAwIDBmIDA1IDw0OD4gM2QgMDAgZjAgZmYg
ZmYgNzcgMzQgNDQgODkgYzcgODkgNDQgMjQgMGMgZTggMDggZDYgZjUgZmYgOGIgNDQKWyA2MzI1
LjcyNDMyMl0gUlNQOiAwMDJiOjAwMDA3ZmZlYmJlMjhmYTAgRUZMQUdTOiAwMDAwMDI5MyBPUklH
X1JBWDogMDAwMDAwMDAwMDAwMDEwMQpbIDYzMjUuNzMxODkwXSBSQVg6IGZmZmZmZmZmZmZmZmZm
ZGEgUkJYOiAwMDAwN2ZlYTEwMDE4NTYwIFJDWDogMDAwMDdmZWM1YzMzZTY1NApbIDYzMjUuNzM5
MDIxXSBSRFg6IDAwMDAwMDAwMDAwODAwMDIgUlNJOiAwMDAwN2ZlYTEwMDE4NTYwIFJESTogMDAw
MDAwMDBmZmZmZmY5YwpbIDYzMjUuNzQ2MTU2XSBSQlA6IDAwMDA3ZmVhMTAwMTg1NjAgUjA4OiAw
MDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAwMDAwMApbIDYzMjUuNzUzMjg3XSBSMTA6
IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwMDAwMDAwMDAwMjkzIFIxMjogMDAwMDAwMDAwMDA4
MDAwMgpbIDYzMjUuNzYwNDE5XSBSMTM6IDAwMDA3ZmVjNWIzMjhlNzAgUjE0OiAwMDAwN2ZlYzVi
MzI4ZTgwIFIxNTogMDAwMDAwMDAwMDAwMDAwMgpbIDYzMjUuNzY3NTUyXSAgPC9UQVNLPgpbIDYz
MjUuNzY5NzQ0XSBNb2R1bGVzIGxpbmtlZCBpbjogYWN0X3NrYmVkaXQgYWN0X21pcnJlZCBtbHg1
X3ZkcGEgdnJpbmdoIHZob3N0X3ZkcGEgdmhvc3Qgdmhvc3RfaW90bGIgdmRwYSBjbHNfbWF0Y2hh
bGwgbmZuZXRsaW5rX2N0dGltZW91dCBuZm5ldGxpbmsgYWN0X2dhY3QgY2xzX2Zsb3dlciBzY2hf
aW5ncmVzcyBvcGVudnN3aXRjaCBuZl9jb25uY291bnQgbmZfbmF0IG5mX2Nvbm50cmFjayBuZl9k
ZWZyYWdfaXB2NiBuZl9kZWZyYWdfaXB2NCBycGNzZWNfZ3NzX2tyYjUgYXV0aF9ycGNnc3MgbmZz
djQgZG5zX3Jlc29sdmVyIG5mcyBsb2NrZCBncmFjZSBmc2NhY2hlIG5ldGZzIGJyaWRnZSBzdHAg
bGxjIHFydHIgaW50ZWxfcmFwbF9tc3IgaW50ZWxfcmFwbF9jb21tb24gaW50ZWxfdW5jb3JlX2Zy
ZXF1ZW5jeSBpbnRlbF91bmNvcmVfZnJlcXVlbmN5X2NvbW1vbiBpMTBubV9lZGFjIG5maXQgbGli
bnZkaW1tIHg4Nl9wa2dfdGVtcF90aGVybWFsIGludGVsX3Bvd2VyY2xhbXAgY29yZXRlbXAga3Zt
X2ludGVsIG1seDVfaWIga3ZtIGRlbGxfd21pIGxlZHRyaWdfYXVkaW8gaVRDT193ZHQgaWJfdXZl
cmJzIGlzc3RfaWZfbW1pbyBzcGFyc2Vfa2V5bWFwIGliX2NvcmUgaVRDT192ZW5kb3Jfc3VwcG9y
dCBpcnFieXBhc3MgaXNzdF9pZl9tYm94X3BjaSBpbnRlbF92c2VjIGFjcGlfaXBtaSBpc3N0X2lm
X2NvbW1vbiBpMmNfaTgwMSByZmtpbGwgcmFwbCBpcG1pX3NzaWYgdmlkZW8gZGVsbF9zbWJpb3Mg
am95ZGV2IGRheF9obWVtIGN4bF9hY3BpIGludGVsX2NzdGF0ZSBtZWlfbWUgaXBtaV9zaSBkZWxs
X3dtaV9kZXNjcmlwdG9yIG1laSB3bWlfYm1vZiBkY2RiYXMgaW50ZWxfcGNoX3RoZXJtYWwgaXBt
aV9kZXZpbnRmIGludGVsX3VuY29yZSBpcG1pX21zZ2hhbmRsZXIgY3hsX2NvcmUgaTJjX3NtYnVz
IHBjc3BrciBhY3BpX3Bvd2VyX21ldGVyIHhmcyBsaWJjcmMzMmMgc2RfbW9kIG1nYWcyMDAgbnZt
ZV90Y3Agc2cgaTJjX2FsZ29fYml0IG52bWVfZmFicmljcyBkcm1fc2htZW1faGVscGVyIG52bWVf
Y29yZQpbIDYzMjUuNzY5ODAwXSAgZHJtX2ttc19oZWxwZXIgbnZtZV9jb21tb24gYWhjaSBjcmN0
MTBkaWZfcGNsbXVsIG1seDVfY29yZSB0MTBfcGkgbGliYWhjaSBjcmMzMl9wY2xtdWwgZHJtIG1s
eGZ3IGNyYzMyY19pbnRlbCBsaWJhdGEgcHNhbXBsZSBtZWdhcmFpZF9zYXMgdGczIGdoYXNoX2Ns
bXVsbmlfaW50ZWwgcGNpX2h5cGVydl9pbnRmIHdtaSBkbV9tdWx0aXBhdGggc3VucnBjIGRtX21p
cnJvciBkbV9yZWdpb25faGFzaCBkbV9sb2cgZG1fbW9kIGJlMmlzY3NpIGJueDJpIGNuaWMgdWlv
IGN4Z2I0aSBjeGdiNCB0bHMgbGliY3hnYmkgbGliY3hnYiBxbGE0eHh4IGlzY3NpX2Jvb3Rfc3lz
ZnMgaXNjc2lfdGNwIGxpYmlzY3NpX3RjcCBsaWJpc2NzaSBzY3NpX3RyYW5zcG9ydF9pc2NzaSBm
dXNlClsgNjMyNS44OTQyNDJdIENSMjogMDAwMDAwMDEwMDViNGFmNApbIDYzMjUuODk3NTYwXSAt
LS1bIGVuZCB0cmFjZSAwMDAwMDAwMDAwMDAwMDAwIF0tLS0KWyA2MzI1Ljk2NzQzMF0gcHN0b3Jl
OiBiYWNrZW5kIChlcnN0KSB3cml0aW5nIGVycm9yICgtMjgpClsgNjMyNS45NzI1NzBdIFJJUDog
MDAxMDpfY29tcGF0X3ZkcGFfcmVzZXQuaXNyYS4wKzB4MjcvMHhiMCBbdmhvc3RfdmRwYV0KWyA2
MzI1Ljk3OTA5NF0gQ29kZTogOTAgOTAgOTAgMGYgMWYgNDQgMDAgMDAgNDEgNTUgNGMgOGQgYWUg
MDggMDMgMDAgMDAgNDEgNTQgNTUgNDggODkgZjUgNTMgNGMgOGIgYTYgMDAgMDMgMDAgMDAgNDgg
ODUgZmYgNzQgNDkgNDggOGIgMDcgNGMgODkgZWYgPDQ4PiA4YiA4MCA4OCA0NSAwMCAwMCA0OCBj
MSBlOCAwOCA0OCA4MyBmMCAwMSA4OSBjMyBlOCA3MyA1ZSA5YiBkYwpbIDYzMjUuOTk3ODQwXSBS
U1A6IDAwMTg6ZmY3M2E4NTc2MjA3M2JhMCBFRkxBR1M6IDAwMDEwMjg2ClsgNjMyNi4wMDMwNjdd
IFJBWDogMDAwMDAwMDEwMDViMDU2YyBSQlg6IGZmMzJiMTNjYTY5OTRjNjggUkNYOiAwMDAwMDAw
MDAwMDAwMDAyClsgNjMyNi4wMTAyMDBdIFJEWDogMDAwMDAwMDAwMDAwMDAwMSBSU0k6IGZmMzJi
MTNjMDc1NTkwMDAgUkRJOiBmZjMyYjEzYzA3NTU5MzA4ClsgNjMyNi4wMTczMzJdIFJCUDogZmYz
MmIxM2MwNzU1OTAwMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiBmZjMyYjEyY2E0OTdjMGYw
ClsgNjMyNi4wMjQ0NjRdIFIxMDogZmY3M2E4NTc2MjA3M2M1OCBSMTE6IDAwMDAwMDBjMTA2Zjlk
ZTMgUjEyOiBmZjMyYjEyYzk1YjFkMDUwClsgNjMyNi4wMzE1OTldIFIxMzogZmYzMmIxM2MwNzU1
OTMwOCBSMTQ6IGZmMzJiMTJkMGRkYzUxMDAgUjE1OiAwMDAwMDAwMDAwMDA4MDAyClsgNjMyNi4w
Mzg3MzFdIEZTOiAgMDAwMDdmZWM1YjhjYmY4MCgwMDAwKSBHUzpmZjMyYjEzYmJmYzgwMDAwKDAw
MDApIGtubEdTOjAwMDAwMDAwMDAwMDAwMDAKWyA2MzI2LjA0NjgxNl0gQ1M6ICAwMDEwIERTOiAw
MDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMwpbIDYzMjYuMDUyNTYzXSBDUjI6IDAw
MDAwMDAxMDA1YjRhZjQgQ1IzOiAwMDAwMDAwMTU2NDRhMDAzIENSNDogMDAwMDAwMDAwMDc3M2Vl
MApbIDYzMjYuMDU5Njk1XSBQS1JVOiA1NTU1NTU1NApbIDYzMjYuMDYyNDA3XSBLZXJuZWwgcGFu
aWMgLSBub3Qgc3luY2luZzogRmF0YWwgZXhjZXB0aW9uClsgNjMyNi4wNjc2NTFdIEtlcm5lbCBP
ZmZzZXQ6IDB4MWM4MDAwMDAgZnJvbSAweGZmZmZmZmZmODEwMDAwMDAgKHJlbG9jYXRpb24gcmFu
Z2U6IDB4ZmZmZmZmZmY4MDAwMDAwMC0weGZmZmZmZmZmYmZmZmZmZmYpClsgNjMyNi4xNDI4OTRd
IC0tLVsgZW5kIEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBGYXRhbCBleGNlcHRpb24gXS0t
LQo=
--0000000000005181b60608874427--

