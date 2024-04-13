Return-Path: <linux-kernel+bounces-143921-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BC6188A3F95
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 01:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 429A51F2198F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 23:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AE65822D;
	Sat, 13 Apr 2024 23:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b="kZBPNveX"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA323FE55
	for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 23:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713050886; cv=none; b=fdHNsOIbgEFTyuwmeYERjuhJSYz/3GxMAOTHkSYXdw6dGBE5OEh+f/WYKFxHlH+9/+IfiNdaGHEe4DCoSWwGNRHZpm/+oqHxhjR94ML7s2EzST9emn+drjf6siyE93aZfuqm3XEVJqoB7JgPRu/svsrc5liXODTr9WKej1OJrkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713050886; c=relaxed/simple;
	bh=xb2ohUo31K9k+PhytPIIpo7xYuKEpF8cczFuUDeF8Es=;
	h=From:Message-Id:Content-Type:Mime-Version:Subject:Date:
	 In-Reply-To:Cc:To:References; b=uFQCME/UTGJUGgduE8TpHwhR7tonEksmLEOfR8AakZtx2W5Zspk+b4zGYWfssHyZDMpMuqLp5IpbyaEKR9nEaB7ZYyP3ngGVtxZvUgjBnUjoxi75f5orPlm+HhRfJ7xXOFSRfFthSIT1L7VzKqoC3mrmSuGZkUHmzJ7HJ8yS+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca; spf=pass smtp.mailfrom=dilger.ca; dkim=pass (2048-bit key) header.d=dilger-ca.20230601.gappssmtp.com header.i=@dilger-ca.20230601.gappssmtp.com header.b=kZBPNveX; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dilger.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dilger.ca
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22a96054726so1630116fac.0
        for <linux-kernel@vger.kernel.org>; Sat, 13 Apr 2024 16:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20230601.gappssmtp.com; s=20230601; t=1713050883; x=1713655683; darn=vger.kernel.org;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=n9/OydLiIC2ol1aX5SLSOMFbjyXKvMnnNcFLUPkVOig=;
        b=kZBPNveXf4/FffpvN+iGQ0pRv9tQLm3TOWRNajql3Q4Z7IeBerAR/6JJhIAmRb79ni
         T2EXxdjxpXuJBU6qw7RcCw8a9lGnc3CM1u6qL6JglD8HwJ1vVFMMFg0nEU07nEHdo0Bd
         ZJd3Jvm9dsFmOexPNCJ64vHiuT3sTPdke3T/S5Xx2RJToeA5macgd6s/HdJdsHrtFOVv
         QVD/Ut5nMCil53tAnEb+ImwCT8gdYJDImBdmKHBcDE9zf2v5X18h5yeC3SwS+5ogg2bj
         htkXJavcCkY7mLejhPM3KKwtipHJp1PExL31va3tHwmv4YvKYVvlI7QeIPXVQX59oAPn
         mgfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713050883; x=1713655683;
        h=references:to:cc:in-reply-to:date:subject:mime-version:message-id
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n9/OydLiIC2ol1aX5SLSOMFbjyXKvMnnNcFLUPkVOig=;
        b=kQAbVF3oPxpxmpnfQoaFDjeZnf6vY/mhFEwa8dusneFQQT6t1dryq6VSlzmNlrv79M
         rJBd2B/gLwxFzNMch4UHM5ZmBhJSSMFVepsaFnaxZmN0bGeIU2SzpLt0BfkMwQ+IXNB6
         VY7nEQbqY+hDwpj27tOEJmcS5FR8KetlmR5u+qoa1J4wH49sLFDCW63WDDn40l2bQ8PE
         2nJvOqCUZebM1HS+vxx2KRPzVi7NgmSk0r7oj5rT2xV/ysVdoTVE6g4RrOnHZFp+bCz8
         OlIQRi5HyEjWjlybO7hczWVWuG+rm8vYJNk6Q8AYnqnPHLADsRXbCwAq/AjGK851SkvR
         5ovw==
X-Forwarded-Encrypted: i=1; AJvYcCUABKsJT7wASONNi6z+a3Yg0MSMx4U0JufoMsLD9U6XillhtiQbZzqDrmMr0GcH7YQDOq3Zz/EgOjOpd3DDSwJHkxiCVszDJo2wuOAW
X-Gm-Message-State: AOJu0YwEo5GC8EHjnyTnWXoitN7cC6n/qgzimSOMh42nAQ4x+oTTAQ4Z
	P1NHmxPzWn8KqumCDR87bA0bMIirIILbafmNRlBnpa5GZ5IMSRTHpYWX1sPL7Tw=
X-Google-Smtp-Source: AGHT+IHmKHafPJAFrWBQwPVxgyyh/N/Z9jT1s9m/STm5/A+v/TF8Da6Wm4YpGuy2PaUNZdlpkmbQDg==
X-Received: by 2002:a05:6870:ec8d:b0:22e:afe5:8811 with SMTP id eo13-20020a056870ec8d00b0022eafe58811mr7506224oab.47.1713050882676;
        Sat, 13 Apr 2024 16:28:02 -0700 (PDT)
Received: from cabot.adilger.int (S01068c763f81ca4b.cg.shawcable.net. [70.77.200.158])
        by smtp.gmail.com with ESMTPSA id j21-20020a056a00175500b006eaafcb0ba4sm4810209pfc.185.2024.04.13.16.28.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2024 16:28:01 -0700 (PDT)
From: Andreas Dilger <adilger@dilger.ca>
Message-Id: <F8B008EE-22F4-4A3C-A80D-545104520D7D@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_C000EAC3-7C8A-4B66-8179-94F2E4BA6CB0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v2] jbd2: avoid mount failed when commit block is partial
 submitted
Date: Sat, 13 Apr 2024 17:27:54 -0600
In-Reply-To: <20240413013056.1830515-1-yebin10@huawei.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
 Ext4 Developers List <linux-ext4@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Jan Kara <jack@suse.cz>
To: Ye Bin <yebin10@huawei.com>
References: <20240413013056.1830515-1-yebin10@huawei.com>
X-Mailer: Apple Mail (2.3273)


--Apple-Mail=_C000EAC3-7C8A-4B66-8179-94F2E4BA6CB0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

On Apr 12, 2024, at 7:30 PM, Ye Bin <yebin10@huawei.com> wrote:
>=20
> We encountered a problem that the file system could not be mounted in
> the power-off scenario. The analysis of the file system mirror shows =
that
> only part of the data is written to the last commit block.
> The valid data of the commit block is concentrated in the first =
sector.
> However, the data of the entire block is involved in the checksum =
calculation.
> For different hardware, the minimum atomic unit may be different.
> If the checksum of a committed block is incorrect, clear the data =
except the
> 'commit_header' and then calculate the checksum. If the checkusm is =
correct,
> it is considered that the block is partially committed.

I think this is a clever solution to the problem, thanks for submitting
the patch.

> However, if there are valid description/revoke blocks, it is =
considered
> that the data is abnormal and the log replay is stopped.

It would be possible to use the r_count of records in the revoke block
to determine how much of the revoke block is unused and could be zeroed
out to recompute the partial checksum?  That should be relatively safe
to try, as long as r_count is itself checked to fit within the block
before the memory is zeroed, to avoid overflowing the temporary buffer =
size:

       r_count <=3D journal_revoke_records_per_block(journal)


It is open for discussion how much corruption should be allowed in the
journal, since it can be very destructive to copy corrupted blocks from
one place in the journal exactly into important metadata blocks across
the whole filesystem.  That said, the checksums *should* avoid this kind
of problem, and revoke blocks do not contain "metadata" that is copied
into the filesystem but only block numbers to skip.  It is "less bad" if
this was wrong, and having an incomplete journal replay due to minor
corruption that is causing boot failure is also a problem that should be
avoided if it can safely be done.


Additional comments inline below:

> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
> fs/jbd2/recovery.c | 48 ++++++++++++++++++++++++++++++++++++++++++++++
> 1 file changed, 48 insertions(+)
>=20
> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
> index 1f7664984d6e..eb0e026f3109 100644
> --- a/fs/jbd2/recovery.c
> +++ b/fs/jbd2/recovery.c
> @@ -443,6 +443,27 @@ static int =
jbd2_commit_block_csum_verify(journal_t *j, void *buf)
> 	return provided =3D=3D cpu_to_be32(calculated);
> }
>=20
> +static bool jbd2_commit_block_csum_partial_verify(journal_t *j, void =
*buf)
> +{

(style) if this is named jbd2_commit_block_csum_verify_partial() then
it would sort together with jbd2_commit_block_csum_verify() and would
be easier to find with tag completion and grep in the future.

> +	struct commit_header *h;
> +	__be32 provided;
> +	__u32 calculated;
> +	void *tmpbuf;
> +
> +	tmpbuf =3D kzalloc(j->j_blocksize, GFP_KERNEL);
> +	if (!tmpbuf)
> +		return false;
> +
> +	memcpy(tmpbuf, buf, sizeof(struct commit_header));
> +	h =3D tmpbuf;
> +	provided =3D h->h_chksum[0];
> +	h->h_chksum[0] =3D 0;
> +	calculated =3D jbd2_chksum(j, j->j_csum_seed, tmpbuf, =
j->j_blocksize);
> +	kfree(tmpbuf);
> +
> +	return provided =3D=3D cpu_to_be32(calculated);
> +}
> +
> static int jbd2_block_tag_csum_verify(journal_t *j, =
journal_block_tag_t *tag,
> 				      journal_block_tag3_t *tag3,
> 				      void *buf, __u32 sequence)
> @@ -479,6 +500,7 @@ static int do_one_pass(journal_t *journal,
> 	int			descr_csum_size =3D 0;
> 	int			block_error =3D 0;
> 	bool			need_check_commit_time =3D false;
> +	bool                    has_partial_commit =3D false;
> 	__u64			last_trans_commit_time =3D 0, =
commit_time;
>=20
> 	/*
> @@ -590,6 +612,14 @@ static int do_one_pass(journal_t *journal,
> 					next_log_block);
> 			}
>=20
> +			if (pass =3D=3D PASS_SCAN && has_partial_commit) =
{
> +				pr_err("JBD2: Detect validate descriptor =
block %lu after incomplete commit block\n",

(minor) it isn't clear to me what this error message is trying to say?
Should it be something like "detected invalid descriptor block ..."?

> +				       next_log_block);
> +				err =3D -EFSBADCRC;
> +				brelse(bh);
> +				goto failed;
> +			}
> +
> 			/* If it is a valid descriptor block, replay it
> 			 * in pass REPLAY; if journal_checksums enabled, =
then
> 			 * calculate checksums in PASS_SCAN, otherwise,
> @@ -810,6 +840,14 @@ static int do_one_pass(journal_t *journal,
> 			if (pass =3D=3D PASS_SCAN &&
> 			    !jbd2_commit_block_csum_verify(journal,
> 							   bh->b_data)) =
{
> +				if =
(jbd2_commit_block_csum_partial_verify(

If this function was restructured a bit then the code flow would not =
need
to get more complex than it already is.  Something like:

			if (pass =3D=3D PASS_SCAN &&
			    !(jbd2_commit_block_csum_verify(journal,
							    bh->b_data) =
||
			      (has_partial_commit =3D
			       =
jbd2_commit_block_csum_verify_partial(journal,
							    =
bh->b_data))) {

The pr_notice() can be printed by =
jbd2_commit_block_csum_partial_verify()
if the partial checksum is valid, so no need for goto and chksum_ok =
label.

> +					pr_notice("JBD2: Find incomplete =
commit block in transaction %u block %lu\n",
> +						  next_commit_ID, =
next_log_block);
> +					has_partial_commit =3D true;
> +					goto chksum_ok;
> +				}
> 			chksum_error:
> 				if (commit_time < =
last_trans_commit_time)
> 					goto ignore_crc_mismatch;
> @@ -824,6 +862,7 @@ static int do_one_pass(journal_t *journal,
> 				}
> 			}
> 			if (pass =3D=3D PASS_SCAN) {
> +			chksum_ok:
> 				last_trans_commit_time =3D commit_time;
> 				head_block =3D next_log_block;
> 			}
> @@ -843,6 +882,15 @@ static int do_one_pass(journal_t *journal,
> 					  next_log_block);
> 				need_check_commit_time =3D true;
> 			}
> +
> +			if (pass =3D=3D PASS_SCAN && has_partial_commit) =
{
> +				pr_err("JBD2: Detect validate revoke =
block %lu after incomplete commit block\n",

Similarly, I find this error message hard to understand.  Maybe =
"detected invalid revoke block ..."?

> +				       next_log_block);
> +				err =3D -EFSBADCRC;
> +				brelse(bh);
> +				goto failed;
> +			}
> +
> 			/* If we aren't in the REVOKE pass, then we can
> 			 * just skip over this block. */
> 			if (pass !=3D PASS_REVOKE) {
> --
> 2.31.1
>=20


Cheers, Andreas






--Apple-Mail=_C000EAC3-7C8A-4B66-8179-94F2E4BA6CB0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmYbFPoACgkQcqXauRfM
H+B/wQ/9EfXuI6o89DuxifUWUohCT2zbh6lphzZNJXBSYGdhBI6VrbbDlAnoyGMl
Rl1bNGq4kbypDkEeDjOefeN8Oydm/JacN355Dm7O+B3mABTRCkws3N5EOKyPo9pS
qtxyIGUqq2nQ09lkP5v5mt4DZTNH6d7cGm+axlWJUaVaVBs6APoJkNmTxqHcK7wc
GxAhNCHsE+Lgejgl8IGfBkkMLWMqyKksa3t/KpIl0x4djq7oihFGMMooHLAq6DAN
YyMWsin++Ady+PaNGNqffjNlL30kjT/xfSr8MGYHnGFC0dOfkgmWxNV51+gGWtXb
HzS41noOsE1MffwC66sempbfTYFuXCe7qIcCKVSu3MHyoE9CYHRHnJZqOiuyHVUH
fvyMDqI7t5WLLrATs3ROD7oCdMEAaxqiS7FXXDmH14Y9xa+53rYIZK80ZCLQ63aO
dBPyqOM+SU/BWn0AA45Ao90w0twSQExPuBT9v/mC67DE3GZVUZIl6l/tqNa86RxB
3/6Za+Bto7ueMUnsq6GFnUkeI+GbwY3FFoEgDG2OqSeDCSC78s8gyNR5xStqveue
TCq/lEgBDhPRCXIlooL7OGBpaMJi9VmRbVMMugU1WcLDSpMJKeD0xAUJwTijGdOf
WdMNboRVwioXLMcJ6iOl/wUFiUE/rVMl1zc8iVo192RjVGQcBus=
=mSJJ
-----END PGP SIGNATURE-----

--Apple-Mail=_C000EAC3-7C8A-4B66-8179-94F2E4BA6CB0--

