Return-Path: <linux-kernel+bounces-163351-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E1078B69BC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0AB1F22B08
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 05:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D57E17555;
	Tue, 30 Apr 2024 05:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MkxC/Khp"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85A014AAD
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 05:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714453827; cv=none; b=a5PTyHM44BP1V5V5OEXhGp9uYveDwm93PXu0ZkTdVfGa9Omwq0x+HGigeAf2BR3HcnB+Ua+od+dChMhCqhlNXGLsYDIoBRKiwq7lDIIkUIfvuHEDby1wUeDU+DINw4138GOm/NwlF0IzCyArG+9muXyjHGXbvYMCUw+5GRUXU9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714453827; c=relaxed/simple;
	bh=SzgFI/v7Mph6bz64Ohfi7yL2xE/FtnoTbuqrAwoH0Ww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U34dwmf7Yz5mepS2Qqco22Vw+cUqSILa9mq2C/8lm1MDPxzKl3U7iNx3f2Q0BI6WM1yE+YF6htSw/TvfMP+CeCiANqnB0qS+554SZihJ7RnflfU7ydTxckBiYYNAi4Rt+D+nVBfcJPl0/3LEu6DZ/HxI4vXBl+YfjPYglDx+bzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MkxC/Khp; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-51967f75729so6215621e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 22:10:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714453824; x=1715058624; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nm5KSte9EtNP2GBwmXuE8/J8iLTK3PcKydXJnqqMM4g=;
        b=MkxC/KhpfMFWT4uW4IrHjP+iMcb0BZWYnvek7AM9hKYzmMSI87mWWYyZWsEBZFBfvN
         ToVeITf6ZZW03E/3ZoVqBLWgzwkyaReELSIMmIn7Kr+2ZYCxhNNUMOfV8FGbce6Sn3Zz
         9ToA/qdRMpf+9QRQX9KWvT49IYDH+AtPYt9lFgWgOOQOlPgrMMxkLP8MKBi/WxR7WzjF
         JH9JpREE03yzdRHIriZtKBoaF5Rp5JajWUS7PxZTo3IrUSFymMpJMALyAjVan8VfW00G
         ec3EXMu/jkU5XLFSPntM55ulCmo6TE0qrtlX0N6fruPvwPGZZ+wgepzXKJoEiUdydPA1
         nWZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714453824; x=1715058624;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nm5KSte9EtNP2GBwmXuE8/J8iLTK3PcKydXJnqqMM4g=;
        b=vOPXJxqSzDU+B/NmjjTOvLG1bKCyTcOx8NOxcaojx7ksn2bfIh+rtHf0wQKn5IE77Z
         xCKtfemzoT/JReFpG4rtgZBiogczo3a2vz2Vd//lsdz/fA8jb5c+k+lFbvMDZUOnqFpr
         g+nA3FvyLNdU+zkok+GQXIwhyIcl6aRzGFbpM/vPpyaaArF9xd/sNymbc5gXea4jUCTd
         jax1d3AOkU+uothI70VP2qY7DxWYr/fLGkLli2MukWpd1JBHq9YyfIWwwvw5MHTybQCZ
         ATe5XLvf6VhIMxh6P7mZyLR2xH7nmVz+gCjrsFXg5i4iQyn4zCp26NIJxgtMGTn8cHq/
         ZpFA==
X-Forwarded-Encrypted: i=1; AJvYcCW8laSuJPGRfKBOJphaqemDsav+loAvvztX9xK/ks33s26ND9GZ0rfNZmyHJ7ultAtxurOFRmZEHymE7uw5YGx/jlXKi9HkNpPviiu0
X-Gm-Message-State: AOJu0YwpRzc33PEM3TmZkyyi10h1gDzWHiJnEh5Mx8uVjEZd73izgQ9d
	Feue/c4tM0onbA9zybpT8gN0ziW2fBc5dY3TO6bVghINgASfGlwzeUi8WEpmoHDoWFSoW+PA267
	EYqtMDWaszmdarlxHdp36DPzvXds=
X-Google-Smtp-Source: AGHT+IFlfuijYlZUPjalT0bDu+MnlCDwx6EUmLuwJiu1cUJxg8OL495gJRHS9/N1pnZDUvSNoNy44ns4wxPnk4L5vS8=
X-Received: by 2002:a05:6512:3294:b0:51b:567e:7ea4 with SMTP id
 p20-20020a056512329400b0051b567e7ea4mr998553lfe.26.1714453823614; Mon, 29 Apr
 2024 22:10:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430021753.385089-1-brookxu.cn@gmail.com> <8379e4a9-3114-4d35-9d1f-81ca61351b85@nvidia.com>
In-Reply-To: <8379e4a9-3114-4d35-9d1f-81ca61351b85@nvidia.com>
From: =?UTF-8?B?6K645pil5YWJ?= <brookxu.cn@gmail.com>
Date: Tue, 30 Apr 2024 13:10:11 +0800
Message-ID: <CADtkEechcseDatdzoPDrYBapvQ5iTKo3E-tsdiwj2B7euLLwnQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-fabrics: use reserved tag for reg read/write command
To: Chaitanya Kulkarni <chaitanyak@nvidia.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "hch@lst.de" <hch@lst.de>, 
	"kbusch@kernel.org" <kbusch@kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "axboe@kernel.dk" <axboe@kernel.dk>, 
	"sagi@grimberg.me" <sagi@grimberg.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chaitanya Kulkarni <chaitanyak@nvidia.com> =E4=BA=8E2024=E5=B9=B44=E6=9C=88=
30=E6=97=A5=E5=91=A8=E4=BA=8C 11:47=E5=86=99=E9=81=93=EF=BC=9A
>
> On 4/29/2024 7:17 PM, brookxu.cn wrote:
> > From: Chunguang Xu <chunguang.xu@shopee.com>
> >
> > In some scenarios, if too many commands are issued by nvme command in
> > the same time by user tasks, this may exhaust all tags of admin_q. If
> > a reset (nvme reset or IO timeout) occurs before these commands finish,
> > reconnect routine may fail to update nvme regs due to insufficient tags=
,
> > which will cause kernel hang forever. In order to workaround this issue=
,
> > maybe we can let reg_read32()/reg_read64()/reg_write32() use reserved
> > tags. This maybe safe for nvmf:
> >
> > 1. For the disable ctrl path,  we will not issue connect command
> > 2. For the enable ctrl / fw activate path, since connect and reg_xx()
> >     are called serially.
> >
>
> Given the complexity of the scenario described above, is it possible to
> write a script for this scenario that will trigger this and submit to
> blktest ? not that this is a blocker to get this patch reviewed, but
> believe it is needed in long run, WDYT ?

Thanks for you reply, I can easily reproduce it in my VMs by following step=
s:
STEP 1. In order to reduce the complexity of reproduction, I reduce
NVME_AQ_MQ_TAG_DEPTH from 31 to 8

STEP 2. Create a nvme device by NVMe over tcp, such as following command:
nvme connect -t tcp -a 192.168.122.20 -s 4420 -n
nqn.2014-08.org.nvmexpress.mytest

STEP 3. Buind and run the c++ program issues nvme commands as followed:
#include <sys/types.h>
#include <signal.h>
#include <unistd.h>
#include <vector>
#include <set>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>

const int concurrency =3D 64;
std::set<pid_t> chlds;

int __exit =3D 0;
void  sigint_proc(int signo)
{
        __exit =3D 1;
}

int main(int argc, char **argv)
{
        signal(SIGINT, sigint_proc);

        for (auto i  =3D 0; i < concurrency; i++) {
                auto pid =3D fork();
                if (!pid) {
                        while (true) {
                                system("nvme list -o json 2>&1 > /dev/null"=
);
                        }
                }

                chlds.insert(pid);
        }

        while (!__exit) {
                if (chlds.empty())
                        break;

                for (auto pid : chlds) {
                        int wstatus, ret;
                        ret =3D waitpid(pid, &wstatus, WNOWAIT);
                        if (ret > 0) {
                                chlds.erase(pid);
                                break;
                        }
                }
                usleep(1000);
        }

        // exit
        for (auto pid : chlds)
                kill(pid, SIGKILL);

        return 0;
}

STEP 4. Open a new console, running the followed command:
while [ true ]; do nvme reset /dev/nvme0; sleep `echo "$RANDOM%1" | bc`; do=
ne

We will reproduce this issue soon.
>
> > So the reserved tags may still be enough while reg_xx() use reserved ta=
gs.
> >
> > Signed-off-by: Chunguang Xu <chunguang.xu@shopee.com>
> > ---
>
> -ck
>
>

